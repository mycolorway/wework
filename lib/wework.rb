require "wework/version"

module Wework
  API_ENDPOINT        = 'https://qyapi.weixin.qq.com/cgi-bin/'.freeze
  ACCESS_TOKEN_PREFIX = 'WEWORK'.freeze
  CONTRACT_APP_ID     = 'CONTRACT'.freeze

  # Exceptions
  class RedisNotConfigException < RuntimeError; end
  class AccessTokenExpiredError < RuntimeError; end
  class ResponseError < StandardError
    attr_reader :error_code
    def initialize(errcode, errmsg)
      @error_code = errcode
      super "#{errmsg}(#{error_code})"
    end
  end
end
