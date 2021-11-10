require 'wework/token/base'

module Wework
  module Token
    class JsAgentTicket < Base

      alias_method :ticket, :token

      def redis_key
        @redis_key ||= Digest::MD5.hexdigest "WX_JS_AGENT_TICKET_#{client.corp_id}_#{client.agent_id}"
      end

      def token_key
        'ticket'
      end

      def refresh_token
        client.get 'ticket/get', params: { type: 'agent_config' }
      end

    end
  end
end
