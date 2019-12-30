module Wework
  module Api
    class Provider < Base
      include Methods::Provider
      include Wework::Cipher

      private

      def token_store
        @token_store ||= Token::ProviderToken.new self
      end

      private

      def token_params
        {provider_access_token: access_token}
      end
    end
  end
end