require 'json'
require 'sinatra/base'

class MockApi < Sinatra::Base

  get '/cgi-bin/media/get' do
    send_file mock_file_path('files/zhiren.png'), :type => :jpg
  end

  get '/cgi-bin/*' do |api|
    json_response "#{api}.json"
  end

  %i(get post).each do |http_method|
    send http_method, '/cgi-bin/*/*' do |category, api|
      json_response "#{category}/#{api}.json"
    end
  end

  private

  def json_response file_name
    content_type :json
    status 200
    file_path = mock_file_path(file_name)
    file_path = mock_file_path('success.json') unless File.exist?(file_path)
    File.open(file_path, 'rb').read
  end

  def mock_file_path path
    File.join(File.expand_path('../../mock_responses/', __FILE__), path)
  end
end