require 'wework/api/oauth'

module Wework
  class Engine

    include Wework::Api::Oauth

    attr_reader :corp_id, :corp_secret, :app_id, :app_secret

    def initialize(options={})
      @corp_id = options[:corp_id]
      @corp_secret = options[:corp_secret]
      @app_id = options[:app_id]
      @app_secret = options[:app_secret]
    end

    def contract
      @contract ||= Wework::Api::Contact.new(corp_id, corp_secret) if contract?
    end

    def agent
      @agent ||= Wework::Api::Agent.new(corp_id, app_id, app_secret) if agent?
    end

    private

    def agent?
      corp_id.present? && app_id.present? && app_secret.present?
    end

    def contract?
      corp_id.present? && corp_secret.present?
    end
  end
end