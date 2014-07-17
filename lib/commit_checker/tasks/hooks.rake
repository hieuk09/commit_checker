require 'highline/import'
require 'open3'

namespace :hooks do
  desc 'Install necessary git hooks'
  task :install do
    hooks = %w[
            applypatch-msg
            pre-applypatch
            post-applypatch
            pre-commit
            prepare-commit-msg
            commit-msg
            post-commit
            pre-rebase
            post-checkout
            post-merge
            pre-receive
            update
            post-receive
            post-update
            pre-auto-gc
    ]

    hooks.each do |hook|
      repo_hook_path = "#{File.dirname(__FILE__)}/#{hook}.template.rb"
      git_hook_path = "#{Rails.root}/.git/hooks/#{hook}"

      if File.exists?(repo_hook_path)

        if File.exists?(git_hook_path) || File.symlink?(git_hook_path)
          should_continue = ''
          while %w[y yes no n].exclude?(should_continue.downcase)
            should_continue = ask("Warning: #{git_hook_path} already exists. Overwrite it? [y/n]: ")
            Open3.capture3("rm -f #{git_hook_path}")
          end
          break if %w[no n].include?(should_continue.downcase)
        end

        stdout_str, stderr_str, status = Open3.capture3("cp #{repo_hook_path} #{git_hook_path}")

        stdout_str, stderr_str, status = Open3.capture3("chmod 755 #{git_hook_path}")
        raise "error: #{stderr_str} for #{hook} when setting permissions to 755" unless status.success?

        stdout_str, stderr_str, status = Open3.capture3("chmod +x #{git_hook_path}")
        raise "error: #{stderr_str} for #{hook} when making executable (chmod +x)" unless status.success?

        if status.success?
          puts "installed #{hook}: copied #{git_hook_path} -> #{repo_hook_path}"
          puts "If you have trouble running your git hook, try changing the shebang line (#!) in #{repo_hook_path}"
        else
          raise "error: #{stderr_str} for #{hook}" unless status.success?
        end
      end
    end
  end
end
