require "bundler/capistrano"
require "rvm/capistrano"

set :whenever_command, "bundle exec whenever"
require "whenever/capistrano"

server "107.170.125.64", :web, :app, :db, primary: true

set :application, "bffgroove"
set :user, "petflow"
set :port, 2048
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:anisharamnani/#{application}.git"
set :branch, "master"


default_run_options[:pty] = true
ssh_options[:keys] = %w(~/.ssh/id_rsa.pub)
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases

namespace :deploy do
  task :start do; end
  task :stop do; end

  desc 'Restart application'
  task :restart, roles: :app do
    run "#{try_sudo} touch #{File.join(release_path,'tmp','restart.txt')}"
  end

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"
end