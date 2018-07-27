module Wework
  module Api
    module Methods
      module Crm
        def crm_get_external_contact external_userid
          get 'crm/get_external_contact', params: {external_userid: external_userid}
        end
      end
    end
  end
end