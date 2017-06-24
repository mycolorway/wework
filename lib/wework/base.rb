require 'wework/request'

module Wework
  class Base

    include Wework::Api::Media

    attr_accessor :corp_id, :secret, :options

    def initialize options={}
      @corp_id      = options.delete(:corp_id)
      @secret       = options.delete(:secret)
      @token_store  = options.delete(:token_store)
      @options      = options
    end

    def request
      @request ||= Wework::Request.new(API_ENDPOINT, false)
    end

    def valid?
      return false if corp_id.nil?
      token_store.token.present?
    rescue AccessTokenExpiredError
      false
    rescue => e
      Rails.logger.error "[WEWORK] (valid?) fetch access token error(#{corp_id}): #{e.inspect}" if defined?(Rails)
      false
    end

    def get(path, headers = {})
      with_token(headers[:params]) do |params|
        request.get path, headers.merge(params: params)
      end
    end

    def post(path, payload, headers = {})
      with_token(headers[:params]) do |params|
        request.post path, payload, headers.merge(params: params)
      end
    end

    def post_file(path, file, headers = {})
      with_token(headers[:params]) do |params|
        request.post_file path, file, headers.merge(params: params)
      end
    end

    def access_token
      token_store.token
    end

    private

    def with_token(params = {}, tries = 2)
      params ||= {}
      yield(params.merge(token_params))
    rescue AccessTokenExpiredError
      token_store.refresh_token
      retry unless (tries -= 1).zero?
    end

    def token_store
      @token_store ||= Token::AppToken.new self
    end

    def token_params
      {access_token: access_token}
    end

  end
end