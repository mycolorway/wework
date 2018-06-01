module Wework
  module Api
    module Methods
      module Department
        def department_create data={}
          post 'department/create', data
        end

        def department_update department_id, data={}
          post 'department/update', data.merge(id: department_id)
        end

        def department_delete department_id
          get 'department/delete', params: {id: department_id}
        end

        def department_list department_id=nil
          if department_id.nil?
            get 'department/list'
          else
            get 'department/list', params: {id: department_id}
          end
        end
      end
    end
  end
end