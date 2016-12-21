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
  #   #puts contact.media_upload('file', File.join(File.dirname(__FILE__), '../../fixtures/user.csv'))
  #   puts contact.media_upload('file', File.join(File.dirname(__FILE__), '../../fixtures/party.csv'))
  # end

  # def test_batch_syncuser
  #   token ='165ff8e819520f8ae8a0000c447c0d91'
  #   encodingaeskey = '7503e83ad9c081f91730e1f3713767b651072a077e861'
  #   media_id = '1qZiLuycGBqpv0WrRsAKwqO5JpLminD17hsTDIsu8JxE'
  #   puts contact.batch_syncuser(media_id, 'https://zhiren.com/test', token, encodingaeskey)
  # end

  # def test_batch_replaceparty
  #   token ='165ff8e819520f8ae8a0000c447c0d91'
  #   encodingaeskey = '7503e83ad9c081f91730e1f3713767b651072a077e861'
  #   media_id = '1_6qVfK98enLrH0qlkvl5osrN05YP5qiv00SuZ2H4xhY'
  #   puts contact.batch_replaceparty(media_id, 'https://zhiren.com/test', token, encodingaeskey)
  # end

  # def test_batch_getresult
  #   puts contact.batch_getresult('1_1482328971_212164')
  # end

  # def test_user_create
  #   info = {
  #     'userid' => 'lili1983',
  #     'name' => '李丽',
  #     'english_name' => 'lili1983',
  #     'mobile' => '13438802101',
  #     'department' => [1, 2],
  #     #'order' => [10,40],
  #     'position' => '工程师',
  #     'gender' => '1',
  #     'email' => '22705030@qq.com',
  #     #'isleader' => 1,
  #     #'avatar_mediaid' => '2-G6nrLmr5EC3MNb_-zL1dDdzkd0p7cNliYu9V5w7o8K0',
  #     'telephone' => '13438802101',
  #     'extattr' => {'attrs' => [{'name' => '爱好','value' => '旅游'}]},
  #     'hide_mobile' => 0
  #   }

  #   result = contact.user_create 'lili1983', '李丽', '13438802101', [1, 2], info
  #   puts result
  # end

  # def test_user_delete
  #   result = contact.user_delete 'lili1983'
  #   p result
  # end

  # def test_user_update
  #   puts contact.user_update 'seandong', {department: [20]}
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
  #   p result
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