module Wework
  module Token
    class Base
      attr_accessor :client

      def initialize(client)
        @client = client
        raise RedisNotConfigException if redis.nil?
      end

      def token
        update_token if expired?
        redis.hget(redis_key, token_key)
      end

      def update_token
        result = refresh_token
        value = result.send(token_key)
        if value.nil?
          raise "#{self.class.name} refresh token error: #{result.inspect}"
        else
          expires_at = Time.now.to_i + result.expires_in.to_i - Wework.expired_shift_seconds

          redis.hmset(
            redis_key,
            token_key, value,
            "expires_at", expires_at
          )

          redis.expireat(redis_key, expires_at)
        end

        value
      end

      private

      def redis
        Wework.redis
      end

      def redis_key
        raise NotImplementedError
      end

      def token_key
        raise NotImplementedError
      end

      def refresh_token
        raise NotImplementedError
      end

      def expired?
        redis.hvals(redis_key).empty? || redis.hget(redis_key, 'expires_at').to_i <= Time.now.to_i
      end
    end
  end
end