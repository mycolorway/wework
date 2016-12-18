module Wework
  module Token
    class RedisStore < Store

      def initialize(agent)
        raise RedisNotConfigException if redis.nil?
        super
      end

      def access_token
        super
        redis.hget(key, "access_token")
      end

      def expired?
        redis.hvals(key).empty?
      end

      def refresh_token
        result = super

        expires_at = Time.now.to_i + result['expires_in'].to_i - 100
        redis.hmset(
          key,
          "access_token", result['access_token'],
          "expires_at", expires_at
        )

        redis.expireat(key, expires_at)
      end

      private

      def redis
        Wework.redis
      end

    end
  end
end
