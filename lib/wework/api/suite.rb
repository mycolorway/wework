module Wework
  module Api
    module Suite
      def corp_authorize_url(redirect_uri, scope="snsapi_base", state="corp_authorize")
        "#{CORP_AUTHORIZE_ENDPOINT}?suite_id=#{suite_id}&pre_auth_code=#{get_pre_auth_code}&redirect_uri=#{redirect_uri}&state=#{state}"
      end

      def get_pre_auth_code
        result = post 'service/get_pre_auth_code', {suite_id: suite_id}
        return result.pre_auth_code if result.success?
      end

      def set_session_info pre_auth_code, session_info={}
        post 'service/set_session_info', {pre_auth_code: pre_auth_code, session_info: session_info}
      end

      def get_permanent_code auth_code
        post 'service/get_permanent_code', {suite_id: suite_id, auth_code: auth_code}
      end

      def get_auth_info auth_corpid, permanent_code
        post 'service/get_auth_info', {suite_id: suite_id, auth_corpid: auth_corpid, permanent_code: permanent_code}
      end

      def get_corp_token auth_corpid, permanent_code
        post 'service/get_corp_token', {suite_id: suite_id, auth_corpid: auth_corpid, permanent_code: permanent_code}
      end

      def get_checkin_data start_time, end_time, userid_list=[], checkin_type=3
        # https://work.weixin.qq.com/api/doc#11196
        post 'checkin/getcheckindata', {
           opencheckindatatype: checkin_type,
           starttime: start_time,
           endtime: end_time,
           useridlist: userid_list,
        }
      end

      def get_approval_data start_time, end_time, next_spnum=nil
        # https://work.weixin.qq.com/api/doc#11228
        payload = {starttime: start_time, endtime: end_time}
        payload[:next_spnum] = next_spnum unless next_spnum.nil?
        post 'corp/getapprovaldata', payload
      end

    end
  end
end