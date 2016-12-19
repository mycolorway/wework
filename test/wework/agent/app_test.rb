require 'test_helper'

class Wework::Agent::AppTest < Minitest::Test

  attr_reader :app

  def setup
    @app = Wework::Agent::App.new(ENV['CORP_ID'], ENV['APP_ID'], ENV['APP_SECRET'])
  end

  def test_access_token
    assert app.access_token
  end
end