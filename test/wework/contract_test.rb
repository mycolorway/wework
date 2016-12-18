require 'test_helper'

class Wework::ContractTest < Minitest::Test

  attr_reader :contract

  def setup
    @contract = Wework::Contract.new(ENV['CORP_ID'], ENV['CORP_SECRET'])
  end

  def test_access_token
    assert contract.access_token
  end
end