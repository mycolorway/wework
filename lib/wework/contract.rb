module Wework
  class Contract < Agent
    def initialize(corp_id, secret)
      super(corp_id, CONTRACT_APP_ID, secret)
    end
  end
end