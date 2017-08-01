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

unless ENV['IGNORE_WEWORK_MOCK']
  require 'webmock/minitest'
  Dir[File.join(File.dirname(__FILE__), 'support/**/*.rb')].each {|f| require f}
end

class Minitest::Test
  def before_setup
    stub_request(:any, /qyapi.weixin.qq.com/).to_rack(FakeWework) unless ENV['IGNORE_WEWORK_MOCK']

    Wework.configure do |config|
      config.redis = MockRedis.new
    end
  end
end