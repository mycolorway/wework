require 'test_helper'

class Wework::AgentTest < Minitest::Test

  attr_reader :agent

  def setup
    @agent = Wework::Agent.new(corp_id: ENV['CORP_ID'], agent_id: ENV['APP_ID'], secret: ENV['APP_SECRET'])
  end

  def test_authorize_url
    assert agent.authorize_url('https://zhiren.com')
  end

  def test_jsapi_ticket
    assert agent.jsapi_ticket
  end

  def test_jssign_package
    package = agent.get_jssign_package('https://zhiren.com')
    assert_instance_of Hash, package
    assert_includes package.keys, 'signature'
    assert_equal ENV['CORP_ID'], package['appId']
  end

  def test_access_token
    assert agent.access_token
  end

  def test_get_info
    assert agent.get_agent.success?
  end

  def test_set_info
    result = agent.set_agent(
      name: '知人',
      redirect_domain: 'zhiren.com',
      description: '智能人力资源管理专家',
      logo_mediaid: image_id
    )

    assert result.success?
  end

  def test_menu_create
    menu = {
      button: [
        {
          type: 'view',
          name: '自助服务',
          url: 'https://zhirenhr.com'
        }
      ]
    }

    assert agent.menu_create(menu).success?
  end

  def test_menu_delete
    assert agent.menu_delete.success?
  end

  def test_media_get
    assert_kind_of Tempfile, agent.media_get(image_id)
  end

  def test_text_message_send
    assert agent.text_message_send('@all', '', '这是一条来自API的测试消息').success?
  end

  def test_image_message_send
    assert agent.image_message_send('@all', '', image_id).success?
  end

  def test_voice_message_send
    assert agent.voice_message_send('@all', '', voice_id).success?
  end

  def test_video_message_send
    assert agent.video_message_send('@all', '', {media_id: video_id, title: '测试', description: '来自API的测试视频'}).success?
  end

  def test_file_message_send
    assert agent.file_message_send('@all', '', file_id).success?
  end

  def test_textcard_message_send
    text_card = {
      title: "测试通知",
      description: "<div class=\"gray\">2016年9月26日</div><br/><br/><br/><br/><div class=\"normal\">大字体呀</div><div class=\"highlight\">我是居中的...</div>",
      url: 'https://zhiren.com',
      btn: '查看详情'
    }

    assert agent.textcard_message_send('@all', '', text_card).success?
  end

  def test_news_message_send
    news = [
      {
        title: "中秋节礼品领取",
        description: "今年中秋节公司有豪礼相送",
        url: "https://zhiren.com",
        picurl: "http://res.mail.qq.com/node/ww/wwopenmng/images/independent/doc/test_pic_msg1.png"
       }
    ]

    assert agent.news_message_send('@all', '', news).success?
  end
  private

  def image_id
    @image_id ||= '1_adABT-H035nwE-zgShL8mZlJQ4d29Xuvfliy3ynzZAhMW5vBoka0P2iAl2daoJU' #@agent.media_upload('image', File.join(File.dirname(__FILE__), '../fixtures/zhiren.png')).media_id
  end

  def file_id
    @file_id ||= '1WGPDpW5r9U6E4vjmcfYJB1vrqOn7nGPuDRR4O9ql0n8' #@agent.media_upload('image', File.join(File.dirname(__FILE__), '../fixtures/sample.txt')).media_id
  end

  def voice_id
    @voice_id ||= '1wIrsgLbIZ-Kn6oUbqnKQR7eE896F-f1J5lTwkQe0aSWhyhKN1uPFCVertUca7gG1' #@agent.media_upload('image', File.join(File.dirname(__FILE__), '../fixtures/sample.amr')).media_id
  end

  def video_id
    @video_id ||= '17kscUIzs_0_bCuugYDv37tjLqewnTOUvj8J59cT5Qg2FTLB8iySF7a1YMCnMBkF-' #@agent.media_upload('image', File.join(File.dirname(__FILE__), '../fixtures/sample.mp4')).media_id
  end
end
