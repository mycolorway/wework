require 'test_helper'

class Wework::ClientTest < Minitest::Test

  attr_reader :wework_api

  def setup
    @wework_api = Wework::Api.new(
      corp_id: ENV['CORP_ID'],
      corp_secret: ENV['CORP_SECRET'],
      app_id: ENV['APP_ID'],
      app_secret: ENV['APP_SECRET']
    )
  end

  test 'validate contract API' do
    assert wework_api.contract
  end

  test 'validate app API' do
    assert wework_api.app
  end
end