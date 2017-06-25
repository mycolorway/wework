require 'wework/token/base'

module Wework
  module Token
    class CorpToken < Base

      def redis_key
        @redis_key ||= Digest::MD5.hexdigest "WX_CORP_TOKEN_#{client.corp_id}"
      end

      def token_key
        'access_token'
      end

      def refresh_token
        client.suite.get_corp_token(client.corp_id, client.permanent_code)
      end
    end
  end
end