require 'wework/token/base'

module Wework
  module Token
    class AppToken < Base

      def redis_key
        @redis_key ||= Digest::MD5.hexdigest "WX_APP_TOKEN_#{client.corp_id}_#{client.secret}"
      end

      def token_key
        'access_token'
      end

      def refresh_token
        client.request.get 'gettoken', params: {corpid: client.corp_id, corpsecret: client.secret}
      end

    end
  end
end