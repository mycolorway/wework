$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'wework'
require "minitest/pride"
require 'minitest/autorun'
require 'minitest/unit'

require 'yaml'


ENV['CORP_ID'] = 'corpid'
ENV['CORP_SECRET'] = 'corp secret'
ENV['APP_ID'] = 'appid'
ENV['APP_SECRET'] = 'app secret'


#load seeds file
seeds_path = File.join(File.dirname(__FILE__), 'fixtures/config.yml')
if File.exist? seeds_path
  YAML.load_file(seeds_path).each do |k, v|
    ENV[k] = "#{v}"
  end
end

class Minitest::Test
  Wework.configure do |config|
    config.redis = Redis.new(host: '127.0.0.1', port: 6379, db: 1)
  end
end