# -*- encoding: utf-8 -*-
require File.expand_path('../lib/check_http_response/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Robert Gogolok"]
  gem.email         = ["gogolok@gmail.com"]
  gem.summary       = %q{checks web server response}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "check_http_response"
  gem.require_paths = ["lib"]
  gem.version       = CheckHttpResponse::VERSION

  gem.add_dependency "httparty", "~> 0.8.1"
end
