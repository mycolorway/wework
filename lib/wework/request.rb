# Reference this: https://github.com/Eric-Guo/wechat/blob/master/lib/wechat/http_client.rb
require 'http'
require 'wework/global_code'

module Wework
  class Request
    attr_reader :base, :ssl_context, :httprb

    def initialize(base, skip_verify_ssl)
      @base = base
      @httprb = HTTP.timeout(**Wework.http_timeout_options)
      @ssl_context = OpenSSL::SSL::SSLContext.new
      @ssl_context.ssl_version = :TLSv1
      @ssl_context.verify_mode = OpenSSL::SSL::VERIFY_NONE if skip_verify_ssl
    end

    def get(path, get_header = {})
      request(path, get_header) do |url, header|
        params = header.delete(:params)
        httprb.headers(header).get(url, params: params, ssl_context: ssl_context)
      end
    end

    def post(path, post_body, post_header = {})
      request(path, post_header) do |url, header|
        params = header.delete(:params)
        httprb.headers(header).post(url, params: params, json: post_body, ssl_context: ssl_context)
      end
    end

    def post_file(path, file, post_header = {})
      request(path, post_header) do |url, header|
        params = header.delete(:params)
        httprb.headers(header)
          .post(url, params: params,
                     form: { media: HTTP::FormData::File.new(file),
                             hack: 'X' }, # Existing here for http-form_data 1.0.1 handle single param improperly
                     ssl_context: ssl_context)
      end
    end

    private

    def request(path, header = {}, &_block)
      url_base = header.delete(:base) || base
      as = header.delete(:as)
      header['Accept'] = 'application/json'
      dup_header = header.dup
      response = yield("#{url_base}#{path}", header)
      raise ResponseError.new(response.status) unless HTTP_OK_STATUS.include?(response.status)

      parse_response(response, as || :json) do |parse_as, data|
        break data unless parse_as == :json
        result = Wework::Result.new(data)
        if defined?(Rails.logger) && Rails.logger
          Rails.logger.debug "[WEWORK] request path(#{url_base}#{path}); request params: #{dup_header.inspect}; response: #{result.inspect}"
        end
        raise AccessTokenExpiredError if result.token_expired?
        result
      end
    end

    def parse_response(response, as)
      content_type = response.headers[:content_type]
      parse_as = {
        %r{^application\/json} => :json,
        %r{^image\/.*} => :file
      }.each_with_object([]) { |match, memo| memo << match[1] if content_type =~ match[0] }.first || as || :text

      case parse_as
      when :file
        file = Tempfile.new('tmp')
        file.binmode
        file.write(response.body)
        file.close
        data = file

      when :json
        data = JSON.parse response.body.to_s
      else
        data = response.body
      end

      yield(parse_as, data)
    end
  end

  class Result < OpenStruct
    def initialize(data)
      data['message'] = GLOBAL_CODES[data['errcode'].to_i]
      data['full_message'] = "#{data['errcode']}：#{data['errmsg']}（#{data['message']}）"
      super data
    end

    def token_expired?
      # 42001: access_token timeout
      # 40014: invalid access_token
      # 40001, invalid credential, access_token is invalid or not latest hint
      [42001, 40014, 40001].include?(errcode)
    end

    def throw_error
      raise ResultErrorException.new(full_message) unless success?
    end

    def success?
      errcode == SUCCESS_CODE
    end
  end
end