require 'test_helper'

class Wework::ProviderTest < Minitest::Test

  attr_reader :provider

  def setup
    @provider = Wework::Provider.new(
      corp_id: ENV['PROVIDER_CORPID'],
      encoding_aes_key: ENV['PROVIDER_ENCODING_AES_KEY'],
      token: ENV['PROVIDER_TOKEN'],
      provider_secret: ENV['PROVIDER_SECRET']
    )
  end

  def test_msg_decrypt
    content = provider.msg_decrypt "9D2OoPwCf0iYCdsEpoHtwRS8hdnJtm98M5IHaUlqCkdokYMsYPBb5H3oPeOpmk7Xe4sifX/vrIcMbS9KIUOV7A=="
    assert_equal content, '7104461721214118143'
  end

  def test_msg_encrypt
    content = provider.msg_encrypt "success"
    puts "content: #{content}"
  end

  def test_generate_xml
    xml = provider.generate_xml('success', Time.now.to_i, SecureRandom.hex)
    puts "xml: #{xml}"
  end

end