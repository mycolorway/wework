module Wework
  module Api
    class Agent < Base

      include Methods::Agent
      include Methods::Message
      include Methods::Appchat
      include Methods::Menu
      include Methods::Checkin
      include Methods::Approval

      attr_reader :agent_id

      def initialize(options={})
        @agent_id = options.delete(:agent_id)
        @agent_id = @agent_id.to_i if @agent_id.to_s =~ /\A\d+\Z/
        super(options)
      end

      def jsapi_ticket
        jsticket_store.ticket
      end

      def jsapi_agent_ticket
        jsticket_agent_store.ticket
      end

      private

      def jsticket_store
        @jsticket_store ||= Token::JsTicket.new self
      end

      def jsticket_agent_store
        @jsticket_agent_store ||= Token::JsAgentTicket.new self
      end
    end
  end
end
