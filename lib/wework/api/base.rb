require 'wework/token/store'
require 'wework/token/redis_store'

require 'wework/js_ticket/store'
require 'wework/js_ticket/redis_store'

module Wework
  module Api
    class Base
      include Wework::Cipher

      attr_reader :corp_id, :app_id, :app_secret
      attr_accessor :options

      delegate :access_token, to: :token_store
      delegate :jsapi_ticket, to: :jsticket_store

      def initialize(corp_id, app_id, app_secret, options={})
        @corp_id      = corp_id
        @app_id       = app_id
        @app_secret   = app_secret
        @options      = options
      end

      def request
        @request ||= Wework::Request.new(API_ENDPOINT, false)
      end

      def valid?
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

      # public API
      def media_upload type, file
        post_file 'media/upload', file, params: { type: type }
      end

      def media_get(media_id)
        get 'media/get', params: { media_id: media_id }, as: :file
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
end