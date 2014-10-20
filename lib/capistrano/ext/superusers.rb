require 'capistrano'

module Capistrano
  module Superusers
    def self.extended(configuration)
      configuration.load do
        def superuser cmd, options={}
          owner       = fetch(:owner,       'nobody')

          user_sudo   = fetch(:user_sudo,   "sudo -u #{owner} -i")
          ssh_forward = fetch(:ssh_forward, "setfacl -m #{owner}:rwx $(dirname $SSH_AUTH_SOCK) && setfacl -m #{owner}:rwx $SSH_AUTH_SOCK")
          shell       = fetch(:user_shell,  :default_shell)

          cmd.gsub! "\n", ""

          run "#{ssh_forward} && #{user_sudo} #{shell} -c '#{cmd}'", options
        end
      end
    end
  end
end

if Capistrano::Configuration.instance
  Capistrano::Configuration.instance.extend(Capistrano::Superusers)
end
