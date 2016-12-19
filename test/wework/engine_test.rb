require 'test_helper'

class Wework::EngineTest < Minitest::Test

  attr_reader :engine

  def setup
    @engine = Wework::Engine.new(
      corp_id: ENV['CORP_ID'],
      corp_secret: ENV['CORP_SECRET'],
      app_id: ENV['APP_ID'],
      app_secret: ENV['APP_SECRET']
    )
  end

  def test_contract_is_valid
    assert engine.contract
  end

  def test_agent_is_valid
    assert engine.agent
  end
end