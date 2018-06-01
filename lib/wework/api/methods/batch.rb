module Wework
  module Api
    module Methods
      module Batch
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
            params[:callback] = {url: callback_url, token: token, encodingaeskey: encodingaeskey}
          end

          params
        end
      end
    end
  end
end