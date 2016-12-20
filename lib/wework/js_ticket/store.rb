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
        app.get 'get_jsapi_ticket'
      end

      private

      def key
        @key ||= Digest::MD5.hexdigest("#{JSAPI_TOKEN_PREFIX}_#{app.app_id}_#{app.app_secret}")
      end

    end
  end
end