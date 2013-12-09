$:.push File.expand_path("../lib", __FILE__)

require 'capistrano/ext/superusers/version'

Gem::Specification.new do |spec|
  spec.name = 'capistrano-ext-superusers'
  spec.version = Capistrano::Ext::Superusers::Version::STRING
  spec.platform = Gem::Platform::RUBY
  spec.authors = ['Funding Circle']
  spec.email = ['james.condron@fundingcircle.co.uk']
  spec.summary = 'Extend out from capistrano deploy user stuff and bits'
  spec.description = 'Capistrano extension to run sensible userage'
  spec.license = 'Simplified BSD'

  spec.add_dependency 'capistrano', '>=2.11.0'
  spec.add_dependency 'capistrano-ext'

  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'capistrano-spec'

  spec.require_path = 'lib'
end
