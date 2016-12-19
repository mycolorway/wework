require "erb"

module Wework
  module Api
    module Oauth

      def authorize_url(redirect_uri, scope="snsapi_base", state="wxwork")
        uri = ERB::Util.url_encode(redirect_uri)
        "#{AUTHORIZE_ENDPOINT}?appid=#{corp_id}&redirect_uri=#{uri}&response_type=code&scope=#{scope}&state=#{state}#wechat_redirect"
      end

    end
  end
end