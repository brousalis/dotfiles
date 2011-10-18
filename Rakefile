task :default => :symlink

desc 'Symlink the dotfiles'
task :symlink do
  puts '* Creating symlinks for the dotfiles'
  Dir.new('.').entries.delete_if{|file| file =~ /\./ || file == 'Rakefile'}.each do |file|
    home_file_path = File.expand_path('~') + '/.' + file
    unless File.exists?(file)
      File.symlink(Dir.getwd + '/' + file, home_file_path)
    end
  end
end

desc 'Pull down latest cnu-toos'
task :cnu do
  puts '* Syncing latests cnu-tools (Mastey) from GitHub'
  `cd $HOME/cnu-tools`
  `git pull origin master`
end

desc 'Pull down latest dotfiles'
task :sync do
  puts '* Syncing latest dotfiles from GitHub'
  `cd $HOME/dotfiles`
  `git pull origin master`
end
