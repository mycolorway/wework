module Wework
  module Api
    module Methods
      module Provider
        def sso_authorize_url(redirect_uri, user_type='admin', state='qywxlogin')
          uri = ERB::Util.url_encode(redirect_uri)
          "#{SSO_AUTHORIZE_ENDPOINT}?appid=#{corp_id}&redirect_uri=#{uri}&state=#{state}&usertype=#{user_type}"
        end

        def get_login_info auth_code
          post 'service/get_login_info', {auth_code: auth_code, access_token: access_token}
        end

        def get_register_code template_id, options={}
          params = {template_id: template_id}
          post 'service/get_register_code', params.merge(options)
        end

        def get_register_url template_id, options={}
          register_code = get_register_code(template_id, options).register_code
          "#{REGISTER_ENDPOINT}?register_code=#{register_code}"
        end
      end
    end
  end
end