# Not the best way to do this
# But it's one way

require 'fileutils'

FileUtils.cd '..' do
  # We install a custom hook because pre-commit is installed in the bundle
  interp =
    if system('which rvm &> /dev/null')
      'rvm default do ruby'
    else
      'ruby'
    end
  File.open('.git/hooks/pre-commit', 'w') do |f|
    f.write <<-eos.strip_heredoc
      #!/usr/bin/env #{interp}
      require 'fileutils'
      FileUtils::cd '#{Rails.root}' do
        require 'bundler/setup'
        require 'pre-commit'
        FileUtils::cd '..' do
          PreCommit.run
        end
      end
    eos
  end
  FileUtils.chmod(0755, '.git/hooks/pre-commit')

  system('git config pre-commit.checks ' +
         '"rubocop_all, debugger, pry, merge_conflict, white_space, tabs, console_log"')
  system('git config core.fileMode false')
  system('git config core.eol lf')
  system('git config core.autocrlf true')
end

