require 'test_helper'

class Wework::Agent::ContractTest < Minitest::Test

  attr_reader :contract

  def setup
    @contract = Wework::Agent::Contract.new(ENV['CORP_ID'], ENV['CORP_SECRET'])
  end

  def test_access_token
    assert contract.access_token
  end

  # def test_user_create
  #   info = {
  #     'userid' => 'zhangsan',
  #     'name' => '张三',
  #     'english_name' => 'jackzhang',
  #     'mobile' => '15913215421',
  #     'department' => [1, 2],
  #     'order' => [10,40],
  #     'position' => '产品经理',
  #     'gender' => '1',
  #     'email' => 'zhangsan@gzdev.com',
  #     'isleader' => 1,
  #     'avatar_mediaid' => '2-G6nrLmr5EC3MNb_-zL1dDdzkd0p7cNliYu9V5w7o8K0',
  #     'telephone' => '13438802101',
  #     'extattr' => {'attrs' => [{'name' => '爱好','value' => '旅游'}]},
  #     'hide_mobile' => 0
  #   }

  #   result = contract.user_create info
  #   puts result
  # end

  # def test_user_update
  #   puts contract.user_update 'bxloved', {department: [4]}
  # end

  # def test_user_simplelist
  #   result = contract.user_simplelist 1, 1
  #   puts result
  # end

  # def test_user_list
  #   result = contract.user_list 1, 1
  #   puts result
  # end

  # def test_department_list
  #   result = contract.department_list
  #   puts result
  # end

  # def test_department_delete
  #   result = contract.department_delete 1
  #   puts result
  # end

  # def test_department_create
  #   result = contract.department_create '产品组', 0
  #   puts result
  # end
end