module Wework
  module Token
    class Store

      attr_accessor :agent

      def initialize(agent)
        @agent = agent
      end

      def access_token
        refresh_token if expired?
      end

      def expired?
        raise NotImplementedError, "Subclasses must implement a token_expired? method"
      end

      def refresh_token
        agent.request.get 'gettoken', params: {corpid: agent.corp_id, corpsecret: agent.agent_secret}
      end

      private

      def key
        @key ||= Digest::MD5.hexdigest("#{ACCESS_TOKEN_PREFIX}_#{agent.agent_id}_#{agent.agent_secret}")
      end

    end
  end
end