require 'wework/token/base'

module Wework
  module Token
    class SuiteToken < Base

      def redis_key
        @redis_key ||= Digest::MD5.hexdigest "WX_SUITE_TOKEN_#{client.suite_id}_#{client.suite_secret}_#{client.suite_token}"
      end

      def token_key
        'suite_access_token'
      end

      def refresh_token
        client.request.post 'service/get_suite_token', {suite_id: client.suite_id, suite_secret: client.suite_secret, suite_ticket: client.suite_ticket}
      end

    end
  end
end