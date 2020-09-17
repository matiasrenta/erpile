#!/home/deployer/railsapps/pile_staging/shared/puma.rb
directory '/home/deployer/railsapps/pile_staging/current'
rackup "/home/deployer/railsapps/pile_staging/current/config.ru"
environment 'production'

tag ''

pidfile "/home/deployer/railsapps/pile_staging/shared/tmp/pids/puma.pid"
state_path "/home/deployer/railsapps/pile_staging/shared/tmp/pids/puma.state"
stdout_redirect '/home/deployer/railsapps/pile_staging/shared/log/puma_access.log', '/home/deployer/railsapps/pile_staging/shared/log/puma_error.log', true

threads 2,3

bind 'unix:///home/deployer/railsapps/pile_staging/shared/tmp/sockets/puma.sock'

workers 2

restart_command 'bundle exec puma'

prune_bundler

on_restart do
  puts 'Refreshing Gemfile'
  ENV["BUNDLE_GEMFILE"] = "/home/deployer/railsapps/pile_staging/current/Gemfile"
end