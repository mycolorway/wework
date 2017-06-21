require 'test_helper'

class Wework::SuiteTest < Minitest::Test

  attr_reader :suite

  def setup
    @suite = Wework::Suite.new(
      corp_id: ENV['SUITE_CORPID'],
      suite_id: ENV['SUITE_ID'],
      encoding_aes_key: ENV['SUITE_ENCODING_AES_KEY'],
      suite_token: ENV['SUITE_TOKEN'],
      suite_secret: ENV['SUITE_SECRET']
    )

    @suite.suite_ticket = ENV['SUITE_TICKET']
  end

  def test_access_token
    assert suite.access_token
  end

  def test_auth_code
    pre_auth_code = suite.get_pre_auth_code
    assert pre_auth_code

    assert suite.set_session_info(pre_auth_code).success?
  end
end