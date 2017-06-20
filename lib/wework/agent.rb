require 'wework/base'

module Wework
  class Agent < Base

    include Wework::Api::Agent

    attr_reader :agent_id

    def initialize(options={})
      @agent_id = options.delete(:agent_id).to_i
      super(options)
    end

  end
end