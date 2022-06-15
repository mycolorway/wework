module Wework
  module Api
    class Provider < Base
      include Methods::Provider
      include Methods::License
      include Wework::Cipher

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