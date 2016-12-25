require 'test_helper'

class Wework::Api::ContactTest < Minitest::Test

  attr_reader :contact

  def setup
    @contact = Wework::Api::Contact.new(ENV['CORP_ID'], ENV['CORP_SECRET'])
  end

  def test_access_token
    assert contact.access_token
  end

  # def test_batch_replaceparty
  #   result = contact.media_upload('file', File.join(File.dirname(__FILE__), '../../fixtures/party.csv'))
  #   p result
  #   assert result.media_id

  #   media_id = result.media_id
  #   token ='165ff8e819520f8ae8a0000c447c0d91'
  #   encodingaeskey = '7503e83ad9c081f91730e1f3713767b651072a077e861'
  #   result = contact.batch_replaceparty(media_id, 'https://zhiren.com/test', token, encodingaeskey)
  #   p result
  #   assert result.jobid

  #   puts contact.batch_getresult(result.jobid)
  # end

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

  # def test_user_create
  #   info = {
  #     userid: 'Keeperlove',
  #     name: '吴松林',
  #     mobile: '+16479897753',
  #     department: [1],
  #     english_name: 'tinyfive',
  #     position: '工程师',
  #   }
  #   result = contact.user_create info
  #   puts result
  # end

  # def test_user_delete
  #   userids = ["AlfredWu", "Betty", "calf", "chenhang", "farthinker", "frankfang", "HeroicYang", "ichord", "leimeng", "manfred", "mybeky", "Sebrina", "yanbi", "terry", "terry", "lili1983", "seandong", "zhangxiaobei", "zhangxiaobei", "xuzheng", "xuzheng", "Keeperlove", "0dcdb2f3e38f65fa34ae70a2971699cc", "d9e423258cfb2a5105f0c77828694f8d", "d027d9c1f56e23d773ea833d78881a4d", "41addb23cec030a475235d8b7f9aa172", "47e455bdf8323361e12049aac3e0983c", "10a13333cf6d90c2d5a8144e97e66caa", "ddf126cdb3d22328fb7bfc09456aa726", "ced3a577dc22baec0facfdb42ee91cfb"]
  #   userids.each do |userid|
  #     result = contact.user_delete userid
  #     p result
  #   end
  # end

  # def test_user_update
  #   puts contact.user_update 'seandong123', {department: [20]}
  # end

  # def test_user_simplelist
  #   result = contact.user_simplelist 1, 1
  #   puts result
  # end

  # def test_user_list
  #   result = contact.user_list 1, 1
  #   p result

  #   p result.userlist.map{|u| u['userid']}
  # end

  # def test_user_get
  #   result = contact.user_get 'seand1ong'
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
  #   result = contact.department_create {name: '工程组', id: 123, parentid: 1}
  #   assert result.success?
  # end
end