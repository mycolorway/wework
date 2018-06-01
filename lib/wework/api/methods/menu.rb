require "erb"

module Wework
  module Api
    module Methods
      module Menu
        def menu_create menu
          post 'menu/create', menu, params: {agentid: agent_id}
        end

        def menu_get
          get 'menu/get', params: {agentid: agent_id}
        end

        def menu_delete
          get 'menu/delete', params: {agentid: agent_id}
        end
      end
    end
  end
end
