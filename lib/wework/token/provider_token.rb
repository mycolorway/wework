require 'wework/token/base'

module Wework
  module Token
    class ProviderToken < Base

      def redis_key
        @redis_key ||= Digest::MD5.hexdigest "WX_PROVIDER_TOKEN_#{client.corp_id}_#{client.secret}"
      end

      def token_key
        'provider_access_token'
      end

      def refresh_token
        client.request.post 'service/get_provider_token', {corpid: client.corp_id, provider_secret: client.secret}
      end

    end
  end
end