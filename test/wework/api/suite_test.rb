require 'test_helper'

class Wework::Api::SuiteTest < Minitest::Test

  attr_reader :suite

  def setup
    @suite = Wework::Api::Suite.new(
      corp_id: ENV['SUITE_CORPID'],
      suite_id: ENV['SUITE_ID'],
      encoding_aes_key: ENV['SUITE_ENCODING_AES_KEY'],
      suite_token: ENV['SUITE_TOKEN'],
      suite_secret: ENV['SUITE_SECRET']
    )

    @suite.suite_ticket = ENV['SUITE_TICKET']
  end

  def test_corp_authorize_url
    assert_match 'zhiren', suite.corp_authorize_url('https://zhiren.com')
  end

  def test_valid?
    assert suite.valid?
  end

  def test_msg_decrypt
    assert_equal 'success', suite.msg_decrypt("KyDloUfxuEE5i5CdHE4zDt1lnQ2qjNHhNShF+vB/bCOfX2EfBzwqRz50j1qurifmECXpnSoV3SCQtPdLqp6GvA==")
  end

  def test_generate_xml
    time = Time.now.to_i
    xml = suite.generate_xml('success', time, SecureRandom.hex)
    assert_equal Hash.from_xml(xml)['xml']['TimeStamp'], time.to_s
  end

  def test_auth_code
    assert suite.get_pre_auth_code
  end

  def test_set_session_info
    assert suite.set_session_info(suite.get_pre_auth_code).success?
  end

  def test_get_permanent_code
    assert suite.get_permanent_code('permanent_code').auth_corp_info
  end

  def test_get_corp_token
    assert suite.get_corp_token('corp_id', 'permanent_code').access_token
  end

end