require 'json'
require 'sinatra/base'

class FakeWework < Sinatra::Base

  get '/cgi-bin/media/get' do
    send_file fixture_file_path('zhiren.png'), :type => :jpg
  end

  get '/cgi-bin/*' do |api|
    json_response "api/#{api}.json"
  end

  %i(get post).each do |http_method|
    send http_method, '/cgi-bin/*/*' do |category, api|
      json_response "api/#{category}/#{api}.json"
    end
  end

  private

  def json_response file_name
    content_type :json
    status 200
    file_path = fixture_file_path(file_name)
    file_path = fixture_file_path('api/success.json') unless File.exist?(file_path)
    File.open(file_path, 'rb').read
  end

  def fixture_file_path path
    File.join(File.expand_path('../../fixtures/', __FILE__), path)
  end
end