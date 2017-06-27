require "capistrano/scm/plugin"

class Capsum::Rsync < Capistrano::SCM::Plugin
  def set_defaults
    set_if_empty :rsync_options, %w(--links --recursive --delete --delete-excluded  --exclude .git*)
    set_if_empty :rsync_copy, "rsync --archive --acls --xattrs"

    # Stage is used on your local machine for rsyncing from.
    set_if_empty :rsync_stage, File.join(Dir.tmpdir, "capsum", Dir.pwd)

    # Cache is used on the server to copy files to from to the release directory.
    set_if_empty :rsync_cache, "shared/deploy"
  end

  def register_hooks
    after "deploy:new_release_path", "rsync:create_release"
    before "deploy:check", "rsync:check"
    before "deploy:set_current_revision", "rsync:set_current_revision"
  end

  def define_tasks
    eval_rakefile File.expand_path("../tasks/rsync.rake", __FILE__)
  end
end
