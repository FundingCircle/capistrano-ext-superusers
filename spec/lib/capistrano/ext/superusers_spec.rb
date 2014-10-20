require 'spec_helper'
require 'capistrano/ext/superusers'

RSpec.describe Capistrano::Superusers do
  let(:config) { Capistrano::Configuration.new }

  before do
    config.extend(Capistrano::Spec::ConfigurationExtension)
    config.extend(Capistrano::Superusers)
  end

  context 'defaults' do
    it 'defines owner, user_shell and user_sudo' do
      expect(config.run).to receive('yolo')
      superuser 'yolo'
    end
  end
end
