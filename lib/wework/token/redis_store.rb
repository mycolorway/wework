module Wework
  module Token
    class RedisStore < Store

      def initialize(agent)
        raise RedisNotConfigException if redis.nil?
        super
      end

      def access_token
        super
        redis.hget(token_key, "access_token")
      end

      def expired?
        redis.hvals(token_key).empty?
      end

      private

      def refresh_token
        result = super

        if result.any?
          expires_in = result['expires_in'].to_i
          redis.hmset(
            token_key,
            "access_token", result['access_token'],
            "expires_at", Time.now.to_i + expires_in
          )
          weixin_redis.expireat(token_key, expires_in - 100)
        end
      end

      def redis
        Wework.redis
      end

    end
  end
end
