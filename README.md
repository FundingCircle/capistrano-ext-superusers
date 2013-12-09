Capistrano::Ext::Superusers
==

A simple rubygem to help run commands and environments as a named user to a common deploy user

Rationale
--

Its pretty common to want to have named access to a server but to be able to automate running and connecting as a shared/common user. And to not over engineer groups and ACLs

Config
--

```ruby
set :owner, 'common_user'             # Defaults to 'nobody'
set :user_sudo, '/path/to/script'     # Defaults to "sudo -u #{owner} -i"
set :ssh_forward, '/path/to/script'   # Defaults to "setfacl -m #{owner}:rx $(dirname $SSH_AUTH_SOCK) && setfacl -m #{owner}:rwx $SSH_AUTH_SOCK")"
```

I don't get it....
--

Consider the simple bundler sort of task as per:

```ruby
namespace :deploy do
  task :bundle do
    run "cd #{current_path} && bundle install --deployment --binstubs --without test cucumber development ruby-debug"
  end
end
```

We could prepend the sudo command (as above) and do:

```ruby
run "sudo -u nobody -i cd #{current_path} && bundle install --deployment --binstubs --without test cucumber development ruby-debug"
```

But this will change the dir as 'nobody' then drop back to the deploy user. We could then do, instead;

```ruby
run "sudo -u nobody -i bash -c 'cd #{current_path} && bundle install --deployment --binstubs --without test cucumber development ruby-debug'"
```

Or; more betterly:

```ruby
run "sudo -u nobody -i  #{default_shell} -c 'cd #{current_path} && bundle install --deployment --binstubs --without test cucumber development ruby-debug'"
```

Which has already lost DRY points.

But what, then, if the Gemfile has gems pointing to git repos we need a key for? We would then need to do two things; add `$SSH_AUTH_SOCK` to env_keep in our sudoers file and then give the `:owner` access to this to. We could extend further without this gem and chain out a massive:

```ruby
run "#{update_perms_on_key} && sudo -u nobody -i  #{default_shell} -c 'cd #{current_path} && bundle install --deployment --binstubs --without test cucumber development ruby-debug'"
```

And, because every new session creates another of these and Capistrano is a tad wasteful we'd end up needing to do this for every `run`.
