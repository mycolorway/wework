module Wework
  module JsTicket
    class RedisStore < Store

      def initialize(agent)
        raise RedisNotConfigException if redis.nil?
        super
      end

      def jsapi_ticket
        super
        redis.hget(key, "ticket")
      end

      def expired?
        redis.hvals(key).empty?
      end

      def refresh_token
        result = super
        if result.success?
          expires_at = Time.now.to_i + result.expires_in.to_i - 100
          redis.hmset(
            key,
            "ticket", result.ticket,
            "expires_at", expires_at
          )

          redis.expireat(key, expires_at)
        end
      end

      private

      def redis
        Wework.redis
      end

    end
  end
end
