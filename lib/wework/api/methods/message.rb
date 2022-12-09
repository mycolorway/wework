require "erb"

module Wework
  module Api
    module Methods
      module Message
        def miniprogram_message_send user_id, miniprogram_notice={}, options={}
          post 'message/send', { touser: user_id, msgtype: 'miniprogram_notice', miniprogram_notice: miniprogram_notice, **options }
        end

        def text_message_send user_ids, department_ids, content
          message_send user_ids, department_ids, {text: {content: content}, msgtype: 'text'}
        end

        def image_message_send user_ids, department_ids, media_id
          message_send user_ids, department_ids, {image: {media_id: media_id}, msgtype: 'image'}
        end

        def voice_message_send user_ids, department_ids, media_id
          message_send user_ids, department_ids, {voice: {media_id: media_id}, msgtype: 'voice'}
        end

        def file_message_send user_ids, department_ids, media_id
          message_send user_ids, department_ids, {file: {media_id: media_id}, msgtype: 'file'}
        end

        def video_message_send user_ids, department_ids, video={}
          message_send user_ids, department_ids, {video: video, msgtype: 'video'}
        end

        def textcard_message_send user_ids, department_ids, textcard={}
          message_send user_ids, department_ids, {textcard: textcard, msgtype: 'textcard'}
        end

        def news_message_send user_ids, department_ids, news=[]
          message_send user_ids, department_ids, {news: {articles: news}, msgtype: 'news'}
        end

        def mpnews_message_send user_ids, department_ids, news=[]
          message_send user_ids, department_ids, {mpnews: {articles: news}, msgtype: 'mpnews'}
        end
        
        def markdown_message_send user_ids, department_ids, content
          message_send user_ids, department_ids, {markdown: {content: content}, msgtype: 'markdown'}
        end
        
        private

        def message_send user_ids, department_ids, payload={}
          payload[:agentid] = agent_id
          payload[:touser] = Array.wrap(user_ids).join('|') if user_ids.present?
          payload[:toparty] = Array.wrap(department_ids).join('|') if department_ids.present?

          post 'message/send', payload
        end
      end
    end
  end
end
