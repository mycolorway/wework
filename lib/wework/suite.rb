require 'wework/base'

module Wework
  class Suite < Base

    include Wework::Api::Suite

    attr_reader :encoding_aes_key, :suite_id, :suite_secret, :suite_token

    def initialize(options={})
      @suite_id = options.delete(:suite_id)
      @suite_secret = options.delete(:suite_secret)
      @suite_token = options.delete(:suite_token)
      super(options)
    end

    def suite_ticket= ticket
      redis.set ticket_key, ticket
    end

    def suite_ticket
      Wework.redis.get ticket_key
    end

    def access_token
      token_store.access_token
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