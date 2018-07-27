require 'builder'

module Wework
  module Api
    class Suite < Base

      include Wework::Cipher
      include Methods::Service

      attr_reader :encoding_aes_key, :suite_id, :suite_secret, :suite_token

      def initialize(options={})
        @suite_id = options.delete(:suite_id)
        @suite_secret = options.delete(:suite_secret)
        @suite_token = options.delete(:suite_token)
        @encoding_aes_key = options.delete(:encoding_aes_key)
        super(options)
      end

      def msg_decrypt message
        unpack(decrypt(Base64.decode64(message), encoding_aes_key))[0]
      end

      def msg_encrypt message
        Base64.strict_encode64(encrypt(pack(message, corp_id), encoding_aes_key))
      end

      def signature(timestamp, nonce, encrypt)
        array = [suite_token, timestamp, nonce]
        array << encrypt unless encrypt.nil?
        Digest::SHA1.hexdigest array.compact.collect(&:to_s).sort.join
      end

      def generate_xml(msg, timestamp, nonce)
        encrypt = msg_encrypt(msg)
        {
          Encrypt: encrypt,
          MsgSignature: signature(timestamp, nonce, encrypt),
          TimeStamp: timestamp,
          Nonce: nonce
        }.to_xml(root: 'xml', children: 'item', skip_instruct: true, skip_types: true)
      end

      def suite_ticket= ticket
        Wework.redis.set ticket_key, ticket
      end

      def suite_ticket
        Wework.redis.get ticket_key
      end

      def corp(corp_id, permanent_code)
        Wework::Api::Corp.new(suite: self, corp_id: corp_id, permanent_code: permanent_code)
      end

      private

      def token_params
        {suite_access_token: access_token}
      end

      def ticket_key
        "SUITE_TICKET_#{suite_id}"
      end

      def token_store
        @token_store ||= Token::SuiteToken.new self
      end

    end
  end
end