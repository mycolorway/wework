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
        redis.hvals(key).empty? || redis.hget(key, "expires_at").to_i <= Time.now.to_i
      end

      def refresh_token
        result = super
        unless result.ticket.nil?
          expires_at = Time.now.to_i + result.expires_in.to_i - Wework.expired_shift_seconds
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
