# Wework

Wework is a ruby API wrapper for work wechat.

[![CircleCI](https://circleci.com/gh/mycolorway/wework/tree/suite.svg?style=svg)](https://circleci.com/gh/mycolorway/wework/tree/suite)

## Version 1.1.0
* 支持第三方应用接口
* 支持小程序接口


## Version 0.1.4
* 异步任务接口 [doc](https://work.weixin.qq.com/api/doc#10138)

## Version 0.1.3

* `access_token` 和 `jsapi_ticket` 管理存储 (默认 redis, 支持其它扩展)
* 通信录相关接口 [Wework::Api::Contact](https://github.com/mycolorway/wework/blob/master/lib/wework/api/contact.rb)
* 企业微信应用接口 [Wework::Api::Agent](https://github.com/mycolorway/wework/blob/master/lib/wework/api/agent.rb)
* API 集成 [Wework::Engine](https://github.com/mycolorway/wework/blob/master/lib/wework/engine.rb)
* 网页授权及[JS-SDK签名算法](https://work.weixin.qq.com/api/doc#10029/附录1-JS-SDK使用权限签名算法)

### TODO：

* 完善测试用例
* 消息接收 [doc](https://work.weixin.qq.com/api/doc#10427)


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

TODO: ...

## Contributing

* Fork `Wework` on GitHub
* Make your changes
* Ensure all tests pass (`bundle exec rake`)
* Send a pull request
* If we like them we'll merge them
* If we've accepted a patch, feel free to ask for commit access!

## License

Copyright (c) 2016 MyColorway. See LICENSE.txt for further details.

