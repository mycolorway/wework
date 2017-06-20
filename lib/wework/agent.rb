require 'wework/base'

module Wework
  class Agent < Base

    include Wework::Api::Agent

    attr_reader :agent_id

    def initialize(options={})
      @agent_id = options.delete(:agent_id).to_i
      super(options)
    end

    def access_token
      token_store.token
    end

    def jsapi_ticket
      jsticket_store.ticket
    end

    private

    def token_store
      @token_store ||= Token::CorpToken.new self
    end

    def jsticket_store
      @jsticket_store ||= Token::JsTicket.new self
    end
  end
end