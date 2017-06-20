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
    content = provider.msg_decrypt "9D2OoPwCf0iYCdsEpoHtwRS8hdnJtm98M5IHaUlqCkdokYMsYPBb5H3oPeOpmk7Xe4sifX/vrIcMbS9KIUOV7A=="
    assert_equal content, '7104461721214118143'
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