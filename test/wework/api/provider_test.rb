require 'test_helper'

class Wework::Api::ProviderTest < Minitest::Test

  attr_reader :provider

  def setup
    @provider = Wework::Api::Provider.new(
      corp_id: ENV['PROVIDER_CORPID'],
      secret: ENV['PROVIDER_SECRET']
    )
  end

  def test_get_login_info
    assert provider.get_login_info('auth code').user_info
  end

  def test_valid?
    assert provider.valid?
  end

end