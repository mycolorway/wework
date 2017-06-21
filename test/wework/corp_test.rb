require 'test_helper'

class Wework::CorpTest < Minitest::Test

  attr_reader :corp

  def setup
    suite = Wework::Suite.new(
      corp_id: ENV['SUITE_CORPID'],
      suite_id: ENV['SUITE_ID'],
      encoding_aes_key: ENV['SUITE_ENCODING_AES_KEY'],
      suite_token: ENV['SUITE_TOKEN'],
      suite_secret: ENV['SUITE_SECRET']
    )

    @corp = suite.corp(ENV['CORP_ID'], ENV['CORP_PERMANENT_CODE'])
  end

  def test_valid
    assert corp.valid?
  end
end