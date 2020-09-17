#!/home/deployer/railsapps/erpile/shared/puma.rb
directory '/home/deployer/railsapps/erpile/current'
rackup "/home/deployer/railsapps/erpile/current/config.ru"
environment 'production'

tag ''

pidfile "/home/deployer/railsapps/erpile/shared/tmp/pids/puma.pid"
state_path "/home/deployer/railsapps/erpile/shared/tmp/pids/puma.state"
stdout_redirect '/home/deployer/railsapps/erpile/shared/log/puma_access.log', '/home/deployer/railsapps/erpile/shared/log/puma_error.log', true

threads 2,3

bind 'unix:///home/deployer/railsapps/erpile/shared/tmp/sockets/puma.sock'

workers 2

restart_command 'bundle exec puma'

prune_bundler

on_restart do
  puts 'Refreshing Gemfile'
  ENV["BUNDLE_GEMFILE"] = "/home/deployer/railsapps/erpile/current/Gemfile"
end