require 'active_support/core_ext/module'
require 'wework/token/store'
require 'wework/token/redis_store'

module Wework
  class Agent

    attr_reader :corp_id, :agent_id, :agent_secret
    attr_accessor :options

    delegate :access_token, to: :token_store

    def initialize(corp_id, agent_id, agent_secret, options={})
      @corp_id      = corp_id
      @agent_id     = agent_id
      @agent_secret = agent_secret
      @options      = options
    end

    def token_store
      @token_store ||= Token::RedisStore.new self
    end

    def request
      @request ||= HttpRequest.new(API_ENDPOINT, false)
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

    def with_access_token(params = {}, tries = 2)
      params ||= {}
      yield(params.merge(access_token: access_token))
    rescue AccessTokenExpiredError
      token_store.refresh_token
      retry unless (tries -= 1).zero?
    end

  end
end