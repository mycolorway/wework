require "erb"

module Wework
  module Api
    module Methods
      module Approval
        def get_approval_data start_time, end_time, next_spnum=nil
          # https://work.weixin.qq.com/api/doc#11228
          payload = {starttime: start_time, endtime: end_time}
          payload[:next_spnum] = next_spnum unless next_spnum.nil?
          post 'corp/getapprovaldata', payload
        end
      end
    end
  end
end
