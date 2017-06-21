require 'wework/token/base'

require 'wework/token/base'

module Wework
  module Token
    class JsTicket < Base

      alias_method :ticket, :token

      def redis_key
        @redis_key ||= Digest::MD5.hexdigest "WX_JS_TICKET_#{client.corp_id}_#{client.agent_id}"
      end

      def token_key
        'ticket'
      end

      def refresh_token
        client.get 'get_jsapi_ticket'
      end

    end
  end
end