module Wework
  class Contract < Agent
    def initialize(corp_id, corp_secret)
      super(corp_id, CONTRACT_APP_ID, corp_secret)
    end
  end
end