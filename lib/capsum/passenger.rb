require File.expand_path("../../capsum.rb", __FILE__)

namespace :deploy do
  desc 'Restart passenger'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :mkdir, '-pv', release_path.join('tmp')
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart
end