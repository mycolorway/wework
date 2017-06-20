require 'wework/request'
require 'wework/token/store'
require 'wework/token/redis_store'

require 'wework/js_ticket/store'
require 'wework/js_ticket/redis_store'

module Wework
  class Base

    include Wework::Api::Media

    attr_accessor :corp_id, :app_secret, :options

    def initialize options={}
      @corp_id      = options.delete(:corp_id)
      @app_secret   = options.delete(:app_secret)
      @options      = options
    end

    def request
      @request ||= Wework::Request.new(API_ENDPOINT, false)
    end

    def valid?
      return false if corp_id.nil?
      access_token.present?
    rescue AccessTokenExpiredError
      false
    rescue => e
      Rails.logger.error "[WEWORK] (valid?) fetch access token error(#{corp_id}##{app_id}): #{e.inspect}" if defined?(Rails)
      false
    end

    def get(path, headers = {})
      with_access_token(headers[:params]) do |params|
        request.get path, headers.merge(params: params)
      end
    end

    def post(path, payload, headers = {})
      with_access_token(headers[:params]) do |params|
        request.post path, payload, headers.merge(params: params)
      end
    end

    def post_file(path, file, headers = {})
      with_access_token(headers[:params]) do |params|
        request.post_file path, file, headers.merge(params: params)
      end
    end

    def access_token
      token_store.access_token
    end

    def jsapi_ticket
      jsticket_store.jsapi_ticket
    end

    private

    def with_access_token(params = {}, tries = 2)
      params ||= {}
      yield(params.merge(access_token: access_token))
    rescue AccessTokenExpiredError
      token_store.refresh_token
      retry unless (tries -= 1).zero?
    end

    def token_store
      @token_store ||= Token::RedisStore.new self
    end

    def jsticket_store
      @jsticket_store ||= JsTicket::RedisStore.new self
    end
  end
end