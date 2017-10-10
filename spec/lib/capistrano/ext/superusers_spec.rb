require 'spec_helper'
require 'capistrano/ext/superusers'

RSpec.describe Capistrano::Configuration do
  describe '.superuser' do
    subject(:configuration) { described_class.new }
    let(:options) { double :options }

    it 'runs a single-line command as a superuser' do
      expect(configuration).to receive(:run).with(
        "setfacl -m nobody:rwx $(dirname $SSH_AUTH_SOCK) && setfacl -m nobody:rwx $SSH_AUTH_SOCK && sudo -u nobody -i default_shell -c 'foo-bar'",
        options
      )
      configuration.superuser("foo-bar", options)
    end

    it 'runs a multi-line command as a superuser' do
      expect(configuration).to receive(:run).with(
        "setfacl -m nobody:rwx $(dirname $SSH_AUTH_SOCK) && setfacl -m nobody:rwx $SSH_AUTH_SOCK && sudo -u nobody -i default_shell -c 'foobar'",
        options
      )
      configuration.superuser("foo\nbar", options)
    end

    context 'with an owner' do
      before do
        allow(configuration).to receive(:fetch).and_call_original
        allow(configuration).to receive(:fetch).with(:owner, 'nobody').and_return('root')
      end

      it 'runs a command as a root' do
        expect(configuration).to receive(:run).with(
          "setfacl -m root:rwx $(dirname $SSH_AUTH_SOCK) && setfacl -m root:rwx $SSH_AUTH_SOCK && sudo -u root -i default_shell -c 'foo-bar'",
          options
        )
        configuration.superuser("foo-bar", options)
      end
    end

    context 'with an user_shell' do
      before do
        allow(configuration).to receive(:fetch).and_call_original
        allow(configuration).to receive(:fetch).with(:user_shell,  :default_shell).and_return('bash')
      end

      it 'runs a command using bash' do
        expect(configuration).to receive(:run).with(
          "setfacl -m nobody:rwx $(dirname $SSH_AUTH_SOCK) && setfacl -m nobody:rwx $SSH_AUTH_SOCK && sudo -u nobody -i bash -c 'foo-bar'",
          options
        )
        configuration.superuser("foo-bar", options)
      end
    end
  end
end
