module Wework
  module Agent
    class Contract < Base

      def initialize(corp_id, corp_secret)
        super(corp_id, CONTRACT_APP_ID, corp_secret)
      end

    end
  end
end