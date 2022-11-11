module Wework
  module Api
    class Provider < Base
      include Methods::Provider
      include Wework::Cipher

      attr_reader :encoding_aes_key, :token

      def initialize(options={})
        @token = options.delete(:token)
        @encoding_aes_key = options.delete(:encoding_aes_key)
        super(options)
      end

      private

      def token_store
        @token_store ||= Token::ProviderToken.new self
      end

      def token_params
        {provider_access_token: access_token}
      end
    end
  end
end