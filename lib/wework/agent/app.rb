module Wework
  module Agent
    class App < Base
      # user agent: UA is mozilla/5.0 (iphone; cpu iphone os 10_2 like mac os x) applewebkit/602.3.12 (khtml, like gecko) mobile/14c92 wxwork/1.3.2 micromessenger/6.2

      def get_info
        get 'agent/get', params: {agentid: agent_id}
      end

      def set_info data={}
        post 'agent/set', data.merge(agentid: agent_id)
      end

      def menu_create menu
        post 'menu/create', menu, params: {agentid: agent_id}
      end

      def menu_delete
        get 'menu/delete', params: {agentid: agent_id}
      end

      def media_upload type, file
        post_file 'media/upload', file, params: { type: type }
      end

      def media_get(media_id)
        get 'media/get', params: { media_id: media_id }, as: :file
      end

      def message_send user_ids, department_ids, payload={}
        payload[:agentid] = agent_id
        payload[:touser] = Array.wrap(user_ids).join('|') if user_ids.present?
        payload[:toparty] = Array.wrap(department_ids).join('|') if department_ids.present?
        post 'message/send', payload
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

      def video_message_send user_ids, department_ids, media_id, title='', description=''
        message_send user_ids, department_ids, {video: {media_id: media_id, title: 'title', description: description}, msgtype: 'video'}
      end

      def textcard_message_send user_ids, department_ids, title, description, url, btntxt='详情'
        message_send user_ids, department_ids, {textcard: {title: title, description: description, url: url, btntxt: btntxt}, msgtype: 'textcard'}
      end

      def news_message_send user_ids, department_ids, news=[]
        message_send user_ids, department_ids, {news: {articles: news}, msgtype: 'news'}
      end

      def agent_id
        @agent_id.to_i
      end
    end
  end
end