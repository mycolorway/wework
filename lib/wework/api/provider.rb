module Wework
  module Api
    class Provider < Base
      include Methods::Provider

      private

      def token_store
        @token_store ||= Token::ProviderToken.new self
      end
    end
  end
end