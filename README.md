# Wechat Work 「企业微信」

Wework is a ruby API wrapper for wechat work「企业微信」.

[企业微信 API 文档](https://work.weixin.qq.com/api/doc)

[![CircleCI](https://circleci.com/gh/mycolorway/wework/tree/suite.svg?style=svg)](https://circleci.com/gh/mycolorway/wework/tree/suite)   [![Gem Version](https://badge.fury.io/rb/wework.svg)](https://badge.fury.io/rb/wework)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'wework'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install wework

## Usage

### 初始化

```
Wework.configure do |config|
  config.redis = Redis.new(host: ENV['REDIS_HOST'], port: ENV['REDIS_PORT'], db: ENV['REDIS_CACHE_DB'])   # redis
  config.http_timeout_options = {write: 15, read: 15, connect: 10}                                        # 请求超时
  config.expired_shift_seconds = 180                                                                      # access token 有效期偏移量 (时间有效期 - 偏移量)
end
```

### 第三方应用

1). 初始化套件接口 [Wework::Api::Suite](https://github.com/mycolorway/wework/blob/master/lib/wework/api/suite.rb)

```ruby
$wework_suite = Wework::Api::Suite.new(
  corp_id: ENV['WEWORK_CORPID'],                            # 应用服务商 CorpID
  suite_id: ENV['WEWORK_SUITE_ID'],                         # SuiteID
  encoding_aes_key: ENV['WEWORK_SUITE_ENCODING_AES_KEY'],   # EncodingAESKey
  suite_token: ENV['WEWORK_SUITE_TOKEN'],                   # Token
  suite_secret: ENV['WEWORK_SUITE_SECRET']                  # Secret
)
```


2). 获取第三方应用接口 [Wework::Api::Agent](https://github.com/mycolorway/wework/blob/master/lib/wework/api/agent.rb)

```ruby
agent_api = $wework_suite.corp(
              corp_id,                                      # 授权企业 CorpID
              permanent_code                                # 永久授权码
            ).agent(agent_id)
```

3). 第三方应用回调协议

获取加密数据

```ruby
encrypt_str = if params[:xml].present?
                params[:xml]['Encrypt']
              else
                Hash.from_xml(request.raw_post)['xml']['Encrypt']
              end

#首次校验接口 encrpt_str = params[:echostr]
```

消息签名

```ruby
$wework_suite.signature(timestamp, nonce, encrypt_str)
```

 消息解密

 ```ruby
 $wework_suite.msg_decrypt(encrypt_data)
 ```


### 自建应用

初始化接口 [Wework::Api::Agent](https://github.com/mycolorway/wework/blob/master/lib/wework/api/agent.rb)

``` ruby
$agent_api = Wework::Api::Agent.new(
  corp_id: ENV['WEWORK_CORPID'],                            # 企业 CorpID
  agent_id: ENV['WEWORK_APPID'],                            # AgentId
  secret: ENV['DEMO_APP_SECRET']                            # Secret
)
```

### 通讯录同步

初始化接口 [Wework::Api::Contact](https://github.com/mycolorway/wework/blob/master/lib/wework/api/contact.rb)

``` ruby
$contact_api = Wework::Api::Contact.new(
  corp_id: ENV['WEWORK_CORPID'],                            # 企业 CorpID
  secret: ENV['DEMO_APP_SECRET']                            # 通讯录同步 Secret
)
```

### 应用服务商接口

初始化

``` ruby
$provider_api = Wework::Api::Provider.new(
  corp_id: ENV['WEWORK_PROVIDER_CORPID'],                     # 应用服务商 CorpID
  secret: ENV['WEWORK_PROVIDER_SECRET'],                      # Secret
  token: ENV['WEWORK_PROVIDER_TOKEN'],
  encoding_aes_key: ENV['WEWORK_PROVIDER_ENCODING_AES_KEY']
)
```

回调接口消息加解密参考「第三方应用回调协议」


### 小程序 encryptedData 解密

```ruby
require "openssl"
CIPHER = 'AES-128-CBC'.freeze

cipher = OpenSSL::Cipher.new(CIPHER)
cipher.decrypt
cipher.key = Base64.decode64(session_key)
cipher.iv = Base64.decode64(iv)
encrypted = Base64.decode64(encryptedData)
data = cipher.update(encrypted) + cipher.final
values = JSON.parse data
```


## 已实现接口列表

[Wework::Api::Methods::Agent](https://github.com/mycolorway/wework/blob/master/lib/wework/api/methods/agent.rb)

[Wework::Api::Methods::User](https://github.com/mycolorway/wework/blob/master/lib/wework/api/methods/user.rb)

[Wework::Api::Methods::Tag](https://github.com/mycolorway/wework/blob/master/lib/wework/api/methods/tag.rb)

[Wework::Api::Methods::Department](https://github.com/mycolorway/wework/blob/master/lib/wework/api/methods/department.rb)

[Wework::Api::Methods::Message](https://github.com/mycolorway/wework/blob/master/lib/wework/api/methods/message.rb)

[Wework::Api::Methods::Media](https://github.com/mycolorway/wework/blob/master/lib/wework/api/methods/media.rb)

[Wework::Api::Methods::Menu](https://github.com/mycolorway/wework/blob/master/lib/wework/api/methods/menu.rb)

[Wework::Api::Methods::Approval](https://github.com/mycolorway/wework/blob/master/lib/wework/api/methods/approval.rb)

[Wework::Api::Methods::Checkin](https://github.com/mycolorway/wework/blob/master/lib/wework/api/methods/checkin.rb)

[Wework::Api::Methods::Batch](https://github.com/mycolorway/wework/blob/master/lib/wework/api/methods/batch.rb)

[Wework::Api::Methods::Provider](https://github.com/mycolorway/wework/blob/master/lib/wework/api/methods/provider.rb)

[Wework::Api::Methods::Service](https://github.com/mycolorway/wework/blob/master/lib/wework/api/methods/service.rb)


## Contributing

* Fork `Wework` on GitHub
* Make your changes
* Ensure all tests pass (`bundle exec rake`)
* Send a pull request
* If we like them we'll merge them
* If we've accepted a patch, feel free to ask for commit access!

## License

Copyright (c) 2018 MyColorway. See LICENSE.txt for further details.

