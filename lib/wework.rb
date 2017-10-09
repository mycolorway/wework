require 'redis'
require 'active_support/all'
#require 'active_support/core_ext/object/blank'

lib = "#{File.dirname(__FILE__)}/wework"
Dir["#{lib}/api/methods/*.rb",  "#{lib}/token/*.rb"].each { |path| require path }

require 'wework/version'
require 'wework/cipher'
require 'wework/config'
require 'wework/api/base'
require 'wework/api/agent'
require 'wework/api/contact'
require 'wework/api/suite'
require 'wework/api/corp'
require 'wework/api/provider'


module Wework
  API_ENDPOINT            = 'https://qyapi.weixin.qq.com/cgi-bin/'.freeze
  AUTHORIZE_ENDPOINT      = 'https://open.weixin.qq.com/connect/oauth2/authorize'.freeze
  SSO_AUTHORIZE_ENDPOINT  = 'https://open.work.weixin.qq.com/wwopen/sso/3rd_qrConnect'.freeze
  CORP_AUTHORIZE_ENDPOINT = 'https://qy.weixin.qq.com/cgi-bin/loginpage'.freeze
  HTTP_OK_STATUS          = [200, 201].freeze
  SUCCESS_CODE            = 0

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
