module Wework

  class << self
    def configure
      yield config
    end

    def config
      @config ||= Config.new
    end

    def redis
      config.redis
    end

    def http_timeout_options
      config.http_timeout_options || {write: 2, connect: 5, read: 10}
    end

    def expired_shift_seconds
      config.expired_shift_seconds || 100
    end
  end

  class Config
    attr_accessor :redis, :http_timeout_options, :expired_shift_seconds
  end
end
