module Wework
  module Api
    module Suite
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
        post 'service/get_auth_info', {suite_id: suite_id, auth_corpid: 'auth_corpid', }
      end
    end
  end
end