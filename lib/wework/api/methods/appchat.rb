require "erb"

module Wework
  module Api
    module Methods
      module Appchat

        def create_group group_name, owner_id, group_user_ids, chat_id
          post 'appchat/create',
            name: group_name,
            owner: owner_id,
            userlist: group_user_ids,
            chatid: chat_id
        end

        # name: group_name
        # owner: owner_id
        # add_user_list: add_user_list
        # del_user_list: del_user_list
        def update_group chat_id, payload={}
          payload.merge! chatid: chat_id
          post 'appchat/update', payload
        end

        def get_group chat_id
          get 'appchat/get', { params: { chatid: chat_id } }
        end

        def group_text_message_send chat_id, content
          message_send chat_id, {text: {content: content}, msgtype: 'text'}
        end

        def group_image_message_send chat_id, media_id
          message_send chat_id, {image: {media_id: media_id}, msgtype: 'image'}
        end

        def group_voice_message_send chat_id, media_id
          message_send chat_id, {voice: {media_id: media_id}, msgtype: 'voice'}
        end

        def group_file_message_send chat_id, media_id
          message_send chat_id, {file: {media_id: media_id}, msgtype: 'file'}
        end

        def group_video_message_send chat_id, video={}
          message_send chat_id, {video: video, msgtype: 'video'}
        end

        def group_textcard_message_send chat_id, textcard={}
          message_send chat_id, {textcard: textcard, msgtype: 'textcard'}
        end

        def group_news_message_send chat_id, news=[]
          message_send chat_id, {news: {articles: news}, msgtype: 'news'}
        end

        private

        def message_send chat_id, payload={}
          payload.merge!(chatid: chat_id)
          post 'appchat/send', payload
        end
      end
    end
  end
end
