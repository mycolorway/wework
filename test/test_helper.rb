$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'wework'
require "minitest/pride"
require 'minitest/autorun'
require 'minitest/unit'


ENV['CORP_ID'] = 'ww79c13c8a6183aac6'
ENV['CORP_SECRET'] = 'gLZfbW8ZKIi9JYmL_Ox3t9f0gGz9XC6cDJMvZJ_hqqo'
ENV['APP_ID'] = '1000002'
ENV['APP_SECRET'] = 'z_KipSNwpDXtY6rE5TS1Tiz5Dg2yx5kden0KyCz810s'

class Minitest::Test
  Wework.configure do |config|
    config.redis = Redis.new(host: '127.0.0.1', port: 6379, db: 1)
  end
end