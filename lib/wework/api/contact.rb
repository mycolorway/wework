module Wework
  module Api
    class Contact < Base

      def initialize(corp_id, corp_secret)
        super(corp_id, CONTACT_AGENT_ID, corp_secret)
      end

      def user_create userid, name, mobile, department, data={}
        post 'user/create', data.merge(userid: userid, name: name, mobile: mobile, department: department)
      end

      def user_get userid
        get 'user/get', params: {userid: userid}
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

      def department_create name, parentid=0, data={}
        post 'department/create', data.merge(name: name, parentid: parentid)
      end

      def department_update department_id, data={}
        post 'department/update', data.merge(id: department_id)
      end

      def department_delete department_id
        get 'department/delete', params: {id: department_id}
      end

      def department_list department_id=0
        get 'department/list', params: {id: department_id}
      end

      def batch_syncuser media_id, callback_url=nil, token=nil, encodingaeskey=nil
        post 'batch/syncuser', batch_params(media_id, callback_url, token, encodingaeskey)
      end

      def batch_replaceuser media_id, callback_url=nil, token=nil, encodingaeskey=nil
        post 'batch/replaceuser', batch_params(media_id, callback_url, token, encodingaeskey)
      end

      def batch_replaceparty media_id, callback_url=nil, token=nil, encodingaeskey=nil
        post 'batch/replaceparty', batch_params(media_id, callback_url, token, encodingaeskey)
      end

      def batch_getresult job_id
        get 'batch/getresult', params: {jobid: job_id}
      end

      private

      def batch_params media_id, callback_url, token, encodingaeskey
        params = {media_id: media_id}
        if callback_url.present? && token.present? && encodingaeskey.present?
          params[:callback] = {url: callback, token: token, encodingaeskey: encodingaeskey}
        end
        params
      end
    end
  end
end