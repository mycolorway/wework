module Wework
  module Api
    module Methods
      module User
        def user_create data={}
          post 'user/create', data
        end

        def user_get userid
          get 'user/get', params: {userid: userid}
        end

        def user_getuserid mobile
          post 'user/getuserid', {mobile: mobile}
        end

        def user_update userid, data={}
          post 'user/update', data.merge(userid: userid)
        end

        def user_delete userid
          get 'user/delete', params: {userid: userid}
        end

        def user_batchdelete useridlist=[]
          post 'user/batchdelete', {useridlist: useridlist}
        end

        def user_simplelist department_id, fetch_child=0
          get 'user/simplelist', params: {department_id: department_id, fetch_child: fetch_child}
        end

        def user_list department_id, fetch_child=0
          get 'user/list', params: {department_id: department_id, fetch_child: fetch_child}
        end

        def convert_to_openid userid
          post 'user/convert_to_openid', {userid: userid}
        end

        def convert_to_userid openid
          post 'user/convert_to_userid', {openid: openid}
        end

        def authsucc userid
          get 'user/authsucc', params: {userid: userid}
        end
      end
    end
  end
end