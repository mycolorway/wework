require 'test_helper'

class Wework::CorpTest < Minitest::Test

  attr_reader :corp

  def setup
    @corp = Wework::Corp.new(
      corp_id: ENV['CORP_ID'],
      corp_secret: ENV['CORP_SECRET'],
      app_id: ENV['APP_ID'],
      app_secret: ENV['APP_SECRET']
    )
  end

  def test_contract_is_valid
    assert corp.contract
  end

  def test_app_is_valid
    assert corp.app
  end
end