require 'test_helper'

class Wework::Api::ContactTest < Minitest::Test

  attr_reader :contact

  def setup
    @contact = Wework::Api::Contact.new(ENV['CORP_ID'], ENV['CORP_SECRET'])
  end

  def test_access_token
    assert contact.access_token
  end

  # def test_media_upload
  #   puts contact.media_upload('file', File.join(File.dirname(__FILE__), '../../fixtures/user.csv'))
  # end

  # def test_batch_syncuser
  #   token ='165ff8e819520f8ae8a0000c447c0d91'
  #   encodingaeskey = '7503e83ad9c081f91730e1f3713767b651072a077e861'
  #   media_id = '1_T9WQvN9RmZEwuOVFmhu62Nw5B0KtHcgjepcYBNsle0'
  #   puts contact.batch_syncuser(media_id, 'https://zhiren.com/test', token, encodingaeskey)
  # end

  # def test_batch_getresult
  #   puts contact.batch_getresult('3_1482312132_137596')
  # end

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

  #   result = contact.user_create info
  #   puts result
  # end

  # def test_user_update
  #   puts contact.user_update 'seandong', {department: [3]}
  # end

  # def test_user_simplelist
  #   result = contact.user_simplelist 1, 1
  #   puts result
  # end

  # def test_user_list
  #   result = contact.user_list 1, 1
  #   p result
  # end

  # def test_user_get
  #   result = contact.user_get 'seandong'
  #   p result
  # end

  # def test_department_list
  #   result = contact.department_list
  #   assert result.success?
  # end

  # def test_department_delete
  #   result = contact.department_delete 1
  #   puts result
  # end

  # def test_department_create
  #   result = contact.department_create '工程组', 1
  #   assert result.success?
  # end
end