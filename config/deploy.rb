set :ssh_options, { :forward_agent => true }

set :application, "pdxlocal.alexkroman.com"

role :app, "alex"
set :user, "alex"
set :keep_releases, 2
set :repository,  "ssh://alex/var/git/pdxlocal.git"
set :scm, :git
set :branch, "master"
set :deploy_via, :remote_cache

set :deploy_to, "/var/www/#{application}"

task :after_symlink do
  run "ln -nfs #{shared_path}/system/production.db #{current_path}/production.db"
end

namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

end