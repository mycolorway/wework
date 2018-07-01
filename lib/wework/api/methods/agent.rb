require "erb"

module Wework
  module Api
    module Methods
      module Agent
        def authorize_url(redirect_uri, scope="snsapi_base", state="wxwork")
          # user agent: UA is mozilla/5.0 (iphone; cpu iphone os 10_2 like mac os x) applewebkit/602.3.12 (khtml, like gecko) mobile/14c92 wxwork/1.3.2 micromessenger/6.2
          uri = ERB::Util.url_encode(redirect_uri)
          "#{AUTHORIZE_ENDPOINT}?appid=#{corp_id}&redirect_uri=#{uri}&response_type=code&scope=#{scope}&agentid=#{agent_id}&state=#{state}#wechat_redirect"
        end

        def get_oauth_userinfo code
          get 'user/getuserinfo', params: {code: code}
        end

        def get_user_detail user_ticket
          post 'user/getuserdetail', {user_ticket: user_ticket}
        end

        def get_jssign_package url
          timestamp = Time.now.to_i
          noncestr = SecureRandom.hex(8)
          str = "jsapi_ticket=#{jsapi_ticket}&noncestr=#{noncestr}&timestamp=#{timestamp}&url=#{url}"
          {
            "appId"     => corp_id,
            "nonceStr"  => noncestr,
            "timestamp" => timestamp,
            "url"       => url,
            "signature" => Digest::SHA1.hexdigest(str),
            "rawString" => str
          }
        end

        def get_session_with_jscode(js_code, grant_type='authorization_code')
          post 'miniprogram/jscode2session', {}, params: {js_code: js_code, grant_type: grant_type}
        end

        def get_agent
          get 'agent/get', params: {agentid: agent_id}
        end

        def set_agent data={}
          post 'agent/set', data.merge(agentid: agent_id)
        end
      end
    end
  end
end
