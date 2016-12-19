require 'test_helper'

class Wework::ClientTest < Minitest::Test

  attr_reader :client

  def setup
    @client = Wework::Client.new(
      corp_id: ENV['CORP_ID'],
      corp_secret: ENV['CORP_SECRET'],
      app_id: ENV['APP_ID'],
      app_secret: ENV['APP_SECRET']
    )
  end

  test 'validate contract API' do
    assert client.contract
  end

  test 'validate app API' do
    assert client.app
  end
end