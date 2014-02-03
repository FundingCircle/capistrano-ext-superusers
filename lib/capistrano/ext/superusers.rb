require 'capistrano'
Capistrano::Configuration.class_eval do
  def superuser cmd, options={}
    owner       = fetch(:owner,       'nobody')

    user_sudo   = fetch(:user_sudo,   "sudo -u #{owner} -i")
    ssh_forward = fetch(:ssh_forward, "setfacl -m #{owner}:rx $(dirname $SSH_AUTH_SOCK) && setfacl -m #{owner}:rwx $SSH_AUTH_SOCK")
    shell       = fetch(:user_shell,  :default_shell)
    
    cmd.gsub! "\n", ""

    if options[:key]
      run "#{ssh_forward} && #{user_sudo} #{shell} -c %r!#{cmd}!", options
    else
      run "#{user_sudo} #{shell} -c %r!#{cmd}!", options
    end
  end
end
