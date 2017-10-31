$:.push File.expand_path("../lib", __FILE__)

require 'capistrano/ext/superusers/version'

Gem::Specification.new do |spec|
  spec.name = 'capistrano-ext-superusers'
  spec.version = Capistrano::Ext::Superusers::Version::STRING
  spec.platform = Gem::Platform::RUBY
  spec.authors = ['Funding Circle Engineering']
  spec.email = ['engineering+capistrano-ext-superusers@fundingcircle.com']
  spec.summary = 'Run Capistrano commands as a superuser'
  spec.description = 'Capistrano extension to run commands as an unprivileged user in a sensible manner'
  spec.homepage = 'https://github.com/FundingCircle/capistrano-ext-superusers'
  spec.license = 'BSD-3-Clause'

  spec.files = `git ls-files -z -- ./* ':(exclude)spec/*'`.split("\x0")

  spec.add_dependency 'capistrano', '>=2.11.0'
  spec.add_dependency 'capistrano-ext'

  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'capistrano-spec'

  spec.require_path = 'lib'
end
