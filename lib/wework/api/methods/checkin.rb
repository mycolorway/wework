require "erb"

module Wework
  module Api
    module Methods
      module Checkin
        def get_checkin_data start_time, end_time, userid_list=[], checkin_type=3
          # https://work.weixin.qq.com/api/doc#11196
          post 'checkin/getcheckindata', {
             opencheckindatatype: checkin_type,
             starttime: start_time,
             endtime: end_time,
             useridlist: userid_list,
          }
        end
      end
    end
  end
end
