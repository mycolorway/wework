require 'redis'
require 'active_support/all'
#require 'active_support/core_ext/object/blank'

lib = "#{File.dirname(__FILE__)}/wework"
Dir["#{lib}/api/*.rb",  "#{lib}/token/*.rb"].each { |path| require path }

require 'wework/version'
require 'wework/config'
require 'wework/agent'
require 'wework/contact'
require 'wework/suite'

module Wework
  API_ENDPOINT        = 'https://qyapi.weixin.qq.com/cgi-bin/'.freeze
  AUTHORIZE_ENDPOINT  = 'https://open.weixin.qq.com/connect/oauth2/authorize'.freeze
  HTTP_OK_STATUS      = [200, 201].freeze
  SUCCESS_CODE        = 0

  # Exceptions
  class RedisNotConfigException < RuntimeError; end
  class AccessTokenExpiredError < RuntimeError; end
  class ResultErrorException < RuntimeError; end
  class ResponseError < StandardError
    attr_reader :error_code
    def initialize(errcode, errmsg='')
      @error_code = errcode
      super "(#{error_code}) #{errmsg}"
    end
  end
end
