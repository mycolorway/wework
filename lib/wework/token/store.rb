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
        app.request.get 'gettoken', params: {corpid: app.corp_id, corpsecret: app.app_secret}
      end

      private

      def key
        @key ||= Digest::MD5.hexdigest("#{ACCESS_TOKEN_PREFIX}_#{app.app_id}_#{app.app_secret}")
      end

    end
  end
end