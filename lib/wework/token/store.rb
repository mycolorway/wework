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
        agent.request.get('/gettoken', params: {corpid: agent.corp_id, corpsecret: agent.agent_secret})
      end

      private

      def token_key
        @token_key ||= [ACCESS_TOKEN_PREFIX, agent.agent_id, agent.secret].map(&:to_s).join('_')
      end

    end
  end
end