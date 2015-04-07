require 'bundler/capistrano'

lock '3.4.0'
set :format, :pretty
set :log_level, :debug
set :application, "Hand Me Ups"
set :repository,  "git@github.com:AllPurposeName/the_pivot.git"
set :deploy_to, "/var/www/handmeups.clothing"
set :scm, :git
set :branch, "master"
set :user, "demo"
set :use_sudo, false
set :rails_env, "production"
set :deploy_via, :copy
set :ssh_options, { :forward_agent => true, :port => 4444 }
set :keep_releases, 5
default_run_options[:pty] = true
server "example.com", :app, :web, :db, :primary => true
# Default value for :pty is false
# set :pty, true

namespace :deploy do
  task :start do ; end
  task :stop do ; end

  desc "Symlink shared config files"
  task :symlink_config_files do
    run "#{ sudo } ln -s #{ deploy_to }/shared/config/database.yml #{ current_path }/config/database.yml"
  end
end
# config valid only for current version of Capistrano


# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

# namespace :deploy do
#
#   after :restart, :clear_cache do
#     on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
  #   end
  # end
