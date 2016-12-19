module Wework
  class Client

    attr_reader :corp_id, :corp_secret, :app_id, :app_secret

    def initialize(options={})
      @corp_id = options[:corp_id]
      @corp_secret = options[:corp_secret]
      @app_id = options[:app_id]
      @app_secret = options[:app_secret]
    end

    def contract
      @contract ||= Wework::Agent::Contract.new(corp_id, corp_secret) if contract?
    end

    def app
      @app ||= Wework::Agent::App.new(corp_id, app_id, app_secret) if app?
    end

    private

    def app?
      corp_id.present? && app_id.present? && app_secret.present?
    end

    def contract?
      corp_id.present? && corp_secret.present?
    end
  end
end