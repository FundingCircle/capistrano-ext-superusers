require 'capistrano/all'

Capistrano::Configuration.class_eval do
  def superuser(cmd, options={})
    owner       = fetch(:owner,       'nobody')

    user_sudo   = fetch(:user_sudo,   "sudo -u #{owner} -i")
    ssh_forward = fetch(:ssh_forward, "setfacl -m #{owner}:rwx $(dirname $SSH_AUTH_SOCK) && setfacl -m #{owner}:rwx $SSH_AUTH_SOCK")
    shell       = fetch(:user_shell,  :default_shell)

    single_line_cmd = cmd.gsub("\n", '')
    run("#{ssh_forward} && #{user_sudo} #{shell} -c '#{single_line_cmd}'", options)
  end
end
