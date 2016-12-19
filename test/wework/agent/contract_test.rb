require 'test_helper'

class Wework::Agent::ContractTest < Minitest::Test

  attr_reader :contract

  def setup
    @contract = Wework::Agent::Contract.new(ENV['CORP_ID'], ENV['CORP_SECRET'])
  end

  def test_access_token
    assert contract.access_token
  end
end