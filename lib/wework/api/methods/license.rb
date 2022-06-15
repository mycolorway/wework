module Wework
  module Api
    module Methods
      module License
        def create_new_order(corpid, buyer_userid, account_count={}, account_duration={})
          post 'license/create_new_order',
            corpid: corpid,
            buyer_userid: buyer_userid,
            account_count: account_count,
            account_duration: account_duration
        end

        def create_renew_order_job(corpid, account_list, jobid=nil)
          post 'license/create_renew_order_job',
            corpid: corpid,
            account_list: account_list,
            jobid: jobid
        end

        def submit_order_job(jobid, buyer_userid, account_duration={})
          post 'license/submit_order_job',
            jobid: jobid,
            buyer_userid: buyer_userid,
            account_duration: account_duration
        end

        def list_order(corpid, start_time=nil, end_time=nil)
          post 'license/list_order',
            corpd: corpid,
            start_time: start_time,
            end_time: end_time
        end

        def get_order(order_id)
          post 'license/get_order', order_id: order_id
        end

        def list_order_account(order_id)
          post 'license/list_order_account', order_id: order_id
        end

        def active_account(corpid, userid, active_code)
          post 'license/active_account',
            corpid: corpid,
            userid: userid,
            active_code: active_code
        end

        def batch_active_account(corpid, active_list=[{}])
          post 'license/batch_active_account',
            corpid: corpid,
            active_list: active_list
        end

        def get_active_info_by_code(corpid, active_code)
          post 'license/get_active_info_by_code',
            corpd: corpid,
            active_code: active_code
        end

        def batch_get_active_info_by_code(corpid, active_code_list=[])
          post 'license/batch_get_active_info_by_code',
            corpd: corpid,
            active_code_list: active_code_list
        end

        def list_actived_account(corpd)
          post 'license/list_actived_account', corpd: corpd
        end

        def get_active_info_by_user(corpid, userid)
          post 'license/get_active_info_by_user',
            corpid: corpid,
            userid: userid
        end

        def batch_transfer_license(corpid, transfer_list=[{}])
          post 'license/batch_transfer_license',
            corpid: corpid,
            transfer_list: transfer_list
        end
      end
    end
  end
end
