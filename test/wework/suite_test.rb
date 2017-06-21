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

  def test_corp_authorize_url
    url = suite.corp_authorize_url('https://zhiren.com')
    puts url
    assert url
  end

  def test_valid?
    assert suite.valid?
  end

  def test_msg_decrypt
    content = suite.msg_decrypt "6kL48HdTY9e31TJCUUxmQ3f1W2Kwp0nvi/RnXfkg94/UaVjsl/ayibdzkKaorC81Gv/hNDk43qmLdeXR6q45Tw=="
    assert_equal content, '1932107781389410111'
  end

  def test_msg_encrypt
    content = suite.msg_encrypt "success"
    assert content, 'ojv9M3naVieUzqr0/bFi3PXIrVnTQ10NVjPvsoGmj65/Xqi1qiMH42bbILESGFeZ9U3jzDeYGV5yVKycQWUB4g=='
  end

  def test_generate_xml
    time = Time.now.to_i
    xml = suite.generate_xml('success', time, SecureRandom.hex)
    assert_equal Hash.from_xml(xml)['xml']['TimeStamp'], time.to_s
  end

  def test_auth_code
    pre_auth_code = suite.get_pre_auth_code
    assert pre_auth_code

    assert suite.set_session_info(pre_auth_code).success?
  end

  def test_get_permanent_code
    # result = suite.get_permanent_code 'hzhts7o90DFxbHK7XLRool0Iuw_Hf45Imt5-S9EpOAW7Mk9g6koCehzipFJ9YNSnsavE3iNtu23u8NDW5mMtWS6xYklHL4ViomP7ZItxxD0'
    # puts result.inspect
  end


end