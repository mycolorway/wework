module Wework
  module Api
    module Methods
      module Provider
        def get_login_info auth_code
          post 'service/get_login_info', {auth_code: auth_code}
        end
      end
    end
  end
end