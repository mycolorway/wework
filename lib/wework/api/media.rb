module Wework
  module Api
    module Media
      # public API
      def media_upload(type, file)
        post_file 'media/upload', file, params: { type: type }
      end

      def media_get(media_id)
        get 'media/get', params: { media_id: media_id }, as: :file
      end
    end
  end
end