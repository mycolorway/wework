module Wework
  module Api
    module Methods
      module Suite
        def corp_authorize_url(redirect_uri, state="corp_authorize")
          "#{APP_AUTHORIZE_ENDPOINT}?suite_id=#{suite_id}&pre_auth_code=#{get_pre_auth_code}&redirect_uri=#{redirect_uri}&state=#{state}"
        end

        def get_pre_auth_code
          result = get 'service/get_pre_auth_code'
          return result.pre_auth_code if result.success?
        end

        def set_session_info pre_auth_code, session_info={}
          post 'service/set_session_info', {pre_auth_code: pre_auth_code, session_info: session_info}
        end

        def get_permanent_code auth_code
          post 'service/get_permanent_code', {auth_code: auth_code}
        end

        def get_auth_info auth_corpid, permanent_code
          post 'service/get_auth_info', {auth_corpid: auth_corpid, permanent_code: permanent_code}
        end

        def get_corp_token auth_corpid, permanent_code
          post 'service/get_corp_token', {suite_id: suite_id, auth_corpid: auth_corpid, permanent_code: permanent_code}
        end

        def get_admin_list auth_corpid, agentid
          post 'service/get_admin_list', {auth_corpid: auth_corpid, agentid: agentid}
        end

        def authorize_url(redirect_uri, scope="snsapi_base", state="wxwork")
          uri = ERB::Util.url_encode(redirect_uri)
          "#{AUTHORIZE_ENDPOINT}?appid=#{suite_id}&redirect_uri=#{uri}&response_type=code&scope=#{scope}&state=#{state}#wechat_redirect"
        end

        def get_oauth_userinfo(code)
          get 'service/getuserinfo3rd', params: {access_token: access_token, code: code}
        end

        def get_user_detail(user_ticket)
          post "service/getuserdetail3rd?access_token=#{access_token}", {user_ticket: user_ticket}
        end
      end
    end
  end
end