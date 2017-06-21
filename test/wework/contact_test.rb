require 'test_helper'

class Wework::ContactTest < Minitest::Test

  attr_reader :contact

  def setup
    @contact = Wework::Contact.new(corp_id: ENV['CORP_ID'], secret: ENV['CONTACT_SECRET'])
  end

  def test_valid?
    assert contact.valid?
  end

  def test_user
    userid = '1dfb4e6c58543c33b74af316acb1bec6'
    user = {
      userid: userid,
      name: '老董',
      mobile: '18683689949',
      department: [1],
      english_name: 'seandong',
      position: '工程师',
    }
    contact.user_delete(userid)
    assert contact.user_create(user).success?
    assert contact.user_update(userid, {name: '山居中人'}).success?
    assert contact.user_get(userid).success?
    assert contact.user_delete(userid).success?
    assert contact.user_simplelist(1, 1).success?
    assert contact.user_list(1, 1).success?
  end

  def test_department
    department_id = rand(100000 .. 999999)
    department = {name: "API测试部门#{department_id}", id: department_id, parentid: 1}
    assert contact.department_create(department).success?
    assert contact.department_update(department_id, {name: "API测试部门#{rand(100000 .. 999999)}"}).success?
    assert contact.department_list(department_id).success?
    assert contact.department_delete(department_id).success?
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

  # def test_batch_syncuser
  #   token ='165ff8e819520f8ae8a0000c447c0d91'
  #   encodingaeskey = '7503e83ad9c081f91730e1f3713767b651072a077e861'
  #   media_id = '1qZiLuycGBqpv0WrRsAKwqO5JpLminD17hsTDIsu8JxE'
  #   puts contact.batch_syncuser(media_id, 'https://zhiren.com/test', token, encodingaeskey)
  # end
end