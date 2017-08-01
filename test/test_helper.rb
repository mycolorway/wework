$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'wework'
require 'mock_redis'
require "minitest/pride"
require 'minitest/autorun'
require 'minitest/unit'
require 'yaml'

seeds_path = File.join(File.dirname(__FILE__), 'fixtures/config.yml')
if File.exist? seeds_path
  YAML.load_file(seeds_path).each do |k, v|
    ENV[k] = "#{v}"
  end
end

if ENV['MOCK_WEWORK_API'] == '1'
  require 'webmock/minitest'
  require 'wework/mock_api'
end

class Minitest::Test
  def before_setup
    stub_request(:any, /qyapi.weixin.qq.com/).to_rack(Wework::MockApi) if ENV['MOCK_WEWORK_API'] == '1'
    Wework.configure do |config|
      config.redis = MockRedis.new
    end
  end
end