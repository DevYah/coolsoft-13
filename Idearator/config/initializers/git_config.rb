# Not the best way to do this
# But it's one way

require 'fileutils'

FileUtils.cd '..' do
  # We install a custom hook because pre-commit is installed in the bundle
  File.open('.git/hooks/pre-commit', 'w') do |f|
    f.write <<-eos.strip_heredoc
      #!/usr/bin/env ruby
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
         '"rubocop_all, debugger, pry, merge_conflict, console_log, migrations"')
  system('git config core.fileMode false')
  system('git config core.eol lf')
end

