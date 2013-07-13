# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'caged_chef/version'

Gem::Specification.new do |gem|
  gem.name          = "caged_chef"
  gem.version       = CagedChef::VERSION
  gem.authors       = ["Brandon Dennis"]
  gem.email         = ["toady00@gmail.com"]
  gem.description   = %q{Chef Auth middleware for Faraday}
  gem.summary       = %q{Provides a simple middleware for Faraday requests to use mixlib-authentication to interact with a chef server}
  gem.homepage      = ""
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "bundler", "~> 1.3"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec", "~> 2.4"
  gem.add_development_dependency "timecop", "~> 0.6.1"

  gem.add_dependency "mixlib-authentication", "~> 1.3.0"
  gem.add_dependency "faraday", "~> 0.8.7"
end
