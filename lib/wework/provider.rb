module Wework
  class Provider
    include Wework::Cipher

    attr_accessor :corp_id, :provider_secret, :encoding_aes_key, :token

    def initialize(options={})
      @corp_id = options[:corp_id]
      @provider_secret = options[:provider_secret]
      @encoding_aes_key = options[:encoding_aes_key]
      @token = options[:token]
    end

    def msg_decrypt msg
      unpack(decrypt(Base64.decode64(msg), self.encoding_aes_key))[0]
    end

    def msg_encrypt msg
      Base64.strict_encode64(encrypt(pack(msg, self.corp_id), self.encoding_aes_key))
    end

    def signature(timestamp, nonce, encrypt)
      array = [self.token, timestamp, nonce]
      array << encrypt unless encrypt.nil?
      dev_msg_signature = array.compact.collect(&:to_s).sort.join
      Digest::SHA1.hexdigest(dev_msg_signature)
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
  end
end