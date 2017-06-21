require 'wework/base'

module Wework
  class Agent < Base

    include Wework::Api::Agent

    attr_reader :agent_id

    def initialize(options={})
      @agent_id = options.delete(:agent_id).to_i
      super(options)
    end

    def jsapi_ticket
      jsticket_store.ticket
    end

    private

    def jsticket_store
      @jsticket_store ||= Token::JsTicket.new self
    end
  end
end