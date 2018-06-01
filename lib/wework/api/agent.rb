module Wework
  module Api
    class Agent < Base

      include Methods::Agent
      include Methods::Message
      include Methods::Menu
      include Methods::Checkin
      include Methods::Approval

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
end