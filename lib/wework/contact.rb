require 'wework/base'

module Wework
  class Contact < Base
    include Wework::Api::Contact

    def access_token
      token_store.token
    end

    private

    def token_store
      @token_store ||= Token::CorpToken.new self
    end
  end
end