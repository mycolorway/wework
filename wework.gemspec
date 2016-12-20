# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wework/version'

Gem::Specification.new do |spec|
  spec.name          = "wework"
  spec.version       = Wework::VERSION
  spec.authors       = ["seandong"]
  spec.email         = ["sindon@gmail.com"]

  spec.summary       = spec.description = %q{Ruby API wrapper for work wechat.}
  spec.homepage      = "https://github.com/mycolorway/wework"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'http', '>= 1.0.4', '< 3'
  spec.add_dependency 'activesupport', '~> 5.0'
  spec.add_dependency 'redis', '~>3.2'

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.10"
end
