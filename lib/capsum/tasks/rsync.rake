rsync_plugin = self

rsync_cache = lambda do
  cache = fetch(:rsync_cache)
  cache = deploy_to + "/" + cache if cache && cache !~ /^\//
  cache
end

namespace :rsync do
  task :check do
    # Everything's a-okay inherently!
  end

  task :set_current_revision do
    Dir.chdir fetch(:rsync_stage) do
      set :current_revision, "#{`git rev-parse --short HEAD`}".chomp
    end
  end

  task :create_stage do
    repo_url = fetch(:repo_url, ".")
    deploy_cache_dir = fetch(:rsync_stage)
    if File.directory?(deploy_cache_dir)
      repo_url_changed = false
      Dir.chdir deploy_cache_dir do
        absolute_repo_url = File.absolute_path(repo_url)
        absolute_cache_repo_url = File.absolute_path(`git config --get remote.origin.url`.chomp)
        repo_url_changed = (absolute_repo_url != absolute_cache_repo_url)
      end

      if repo_url_changed
        run_locally { execute :rm, "-rf", deploy_cache_dir }
      else
        next
      end
    end

    clone = %w(git clone)
    clone << repo_url
    clone << deploy_cache_dir
    run_locally { execute *clone }
  end

  desc "Stage the repository in a local directory."
  task stage: %w(create_stage) do
    Dir.chdir fetch(:rsync_stage) do
      update = %w(git fetch --quiet --all --prune)
      run_locally { execute *update }

      checkout = %W(git reset --hard origin/#{fetch(:branch)})
      run_locally { execute *checkout }

      submodule = %w(git submodule update --init --force)
      run_locally { execute *submodule }
    end
  end

  desc "Stage and rsync to the server (or its cache)."
  task sync: %w(stage) do
    roles(:all).each do |role|
      user = role.user + "@" if role.user

      rsync = %w(rsync)

      if (port = role.port)
        rsync += [ "-e", %("ssh -p #{port}") ]
      end

      rsync.concat fetch(:rsync_options)

      rsync << fetch(:rsync_stage) + "/"
      rsync << "#{user}#{role.hostname}:#{rsync_cache.call || release_path}"

      run_locally { execute *rsync }
    end
  end

  desc "Copy the code to the releases directory."
  task create_release: %w(sync) do
    # Skip copying if we've already synced straight to the release directory.
    next if !fetch(:rsync_cache)

    folder = fetch(:rsync_folder, "/")
    copy = %(#{fetch(:rsync_copy)} "#{rsync_cache.call}#{folder}" "#{release_path}/")
    on roles(:all) do
      execute copy
    end
  end
end
