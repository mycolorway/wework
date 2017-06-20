module Wework
  module Token
    class Store

      attr_accessor :app

      def initialize(app)
        @app = app
      end

      def access_token
        refresh_token if expired?
      end

      def expired?
        raise NotImplementedError, "Subclasses must implement a token_expired? method"
      end

      def refresh_token
        result = app.request.get 'gettoken', params: {corpid: app.corp_id, corpsecret: app.app_secret}
        if defined?(Rails)
          Rails.logger.warn "[WEWORK] refresh Token(#{app.corp_id}): #{result.inspect}"
        end

        result
      end

      private

      def key
        @key ||= Digest::MD5.hexdigest("#{ACCESS_TOKEN_PREFIX}_#{app.corp_id}_#{app.app_secret}")
      end

    end
  end
end