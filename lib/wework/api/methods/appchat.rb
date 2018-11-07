require "erb"

module Wework
  module Api
    module Methods
      module Appchat

        def appchat_create group_name, owner_id, group_user_ids, chat_id
          post 'appchat/create',
            name: group_name,
            owner: owner_id,
            userlist: group_user_ids,
            chatid: chat_id
        end

        def appchat_update chat_id, payload={}
          payload.merge! chatid: chat_id
          post 'appchat/update', payload
        end

        def appchat_get chat_id
          get 'appchat/get', { params: { chatid: chat_id } }
        end

        def text_appchat_send chat_id, content
          appchat_send chat_id, {text: {content: content}, msgtype: 'text'}
        end

        def image_appchat_send chat_id, media_id
          appchat_send chat_id, {image: {media_id: media_id}, msgtype: 'image'}
        end

        def voice_appchat_send chat_id, media_id
          appchat_send chat_id, {voice: {media_id: media_id}, msgtype: 'voice'}
        end

        def file_appchat_send chat_id, media_id
          appchat_send chat_id, {file: {media_id: media_id}, msgtype: 'file'}
        end

        def video_appchat_send chat_id, video={}
          appchat_send chat_id, {video: video, msgtype: 'video'}
        end

        def textcard_appchat_send chat_id, textcard={}
          appchat_send chat_id, {textcard: textcard, msgtype: 'textcard'}
        end

        def news_appchat_send chat_id, news=[]
          appchat_send chat_id, {news: {articles: news}, msgtype: 'news'}
        end

        private

        def appchat_send chat_id, payload={}
          payload.merge!(chatid: chat_id)
          post 'appchat/send', payload
        end
      end
    end
  end
end
