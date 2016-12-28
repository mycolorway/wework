module Wework

  class << self
    attr_accessor :config
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
  end

  class Config
    attr_accessor :redis, :http_timeout_options
  end
end
