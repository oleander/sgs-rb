# -*- encoding: utf-8 -*-
require File.expand_path('../lib/sgs/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Linus Oleander"]
  gem.email         = ["linus@oleander.nu"]
  gem.description   = %q{Ruby wrapper for sgsstudentbostader.se}
  gem.summary       = %q{Ruby wrapper for sgsstudentbostader.se}
  gem.homepage      = "https://github.com/oleander/sgs-rb"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "sgs"
  gem.require_paths = ["lib"]
  gem.version       = SGS::VERSION

  gem.add_dependency("rest-client")
  gem.add_dependency("nokogiri")
  
  gem.add_development_dependency("vcr")
  gem.add_development_dependency("rspec")  
  gem.add_development_dependency("webmock")

  gem.required_ruby_version = "~> 1.9.0"
end
