require 'test_helper'

class Wework::ProviderTest < Minitest::Test

  attr_reader :provider

  def setup
    @provider = Wework::Provider.new(
      corp_id: ENV['SUITE_CORPID'],
      encoding_aes_key: ENV['SUITE_ENCODING_AES_KEY'],
      token: ENV['SUITE_TOKEN'],
      provider_secret: ENV['SUITE_SECRET']
    )
  end

  def test_msg_decrypt
    content = provider.msg_decrypt "6kL48HdTY9e31TJCUUxmQ3f1W2Kwp0nvi/RnXfkg94/UaVjsl/ayibdzkKaorC81Gv/hNDk43qmLdeXR6q45Tw=="
    assert_equal content, '1932107781389410111'
  end

  def test_msg_encrypt
    content = provider.msg_encrypt "success"
    assert content, 'ojv9M3naVieUzqr0/bFi3PXIrVnTQ10NVjPvsoGmj65/Xqi1qiMH42bbILESGFeZ9U3jzDeYGV5yVKycQWUB4g=='
  end

  def test_generate_xml
    time = Time.now.to_i
    xml = provider.generate_xml('success', time, SecureRandom.hex)
    assert_equal Hash.from_xml(xml)['xml']['TimeStamp'], time.to_s
  end

end