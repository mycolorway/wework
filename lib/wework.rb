require 'redis'
require 'active_support/all'
#require 'active_support/core_ext/object/blank'

Dir["#{File.dirname(__FILE__)}/wework/*.rb"].each do |path|
  require path
end

require 'wework/api/base'
require 'wework/api/agent'
require 'wework/api/contact'

module Wework
  API_ENDPOINT        = 'https://qyapi.weixin.qq.com/cgi-bin/'.freeze
  AUTHORIZE_ENDPOINT  = 'https://open.weixin.qq.com/connect/oauth2/authorize'.freeze
  ACCESS_TOKEN_PREFIX = 'WEWORK'.freeze
  CONTACT_AGENT_ID    = 'CONTACT'.freeze
  HTTP_OK_STATUS      = [200, 201].freeze
  SUCCESS_CODE        = 0

  # Exceptions
  class RedisNotConfigException < RuntimeError; end
  class AccessTokenExpiredError < RuntimeError; end
  class ResponseError < StandardError
    attr_reader :error_code
    def initialize(errcode, errmsg='')
      @error_code = errcode
      super "(#{error_code}) #{errmsg}"
    end
  end
end
