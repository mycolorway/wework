module Wework
  module JsTicket
    class Store

      attr_accessor :app

      def initialize(app)
        @app = app
      end

      def jsapi_ticket
        refresh_token if expired?
      end

      def expired?
        raise NotImplementedError, "Subclasses must implement a token_expired? method"
      end

      def refresh_token
        result = app.get 'get_jsapi_ticket'
        if defined?(Rails)
          Rails.logger.warn "[WEWORK] refresh JsTicket(#{app.corp_id}): #{result.inspect}"
        end

        result
      end

      private

      def key
        @key ||= Digest::MD5.hexdigest("#{JSAPI_TOKEN_PREFIX}_#{app.corp_id}_#{app.app_secret}")
      end

    end
  end
end