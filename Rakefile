# encoding: UTF-8

require 'rake'

task :install => [:submodules] do
  linkables = Dir.glob('*').reject{|f| f["hosts"] || f["custom"] || f["Rakefile"] || f["osx"]}

  skip_all = false
  overwrite_all = false
  backup_all = false

  puts "✱ Installing Janus"
  `curl -Lo- https://bit.ly/janus-bootstrap | bash`

  puts "✱ Installing oh-my-zsh"
  `curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh`

  puts "✱ Symlinking dotfiles"
  linkables.each do |linkable|
    overwrite = false
    backup = false

    target = "#{ENV["HOME"]}/.#{linkable}"

    if File.exists?(target) || File.symlink?(target)
      unless skip_all || overwrite_all || backup_all
        puts "✖ File already exists: #{target}, what do you want to do? [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all"
        case STDIN.gets.chomp
        when 'o' then overwrite = true
        when 'b' then backup = true
        when 'O' then overwrite_all = true
        when 'B' then backup_all = true
        when 'S' then skip_all = true
        when 's' then next
        end
      end
      FileUtils.rm_rf(target) if overwrite || overwrite_all
      `mv "$HOME/.#{linkable}" "$HOME/backups/.#{linkable}.backup"` if backup || backup_all
    end
    puts "✱ Linked #{target}"
    `ln -s "$PWD/#{linkable}" "#{target}"`
  end
end

task :uninstall do
  linkables = Dir.glob('*').reject{|f| f["Rakefile"] || f["osx"]}
  linkables.each do |linkable|
    target = "#{ENV["HOME"]}/.#{linkable}"

    if File.symlink?(target)
      puts "✱ Removed #{target}"
      FileUtils.rm(target)
    end

    if File.exists?("#{ENV["HOME"]}/.#{linkable}.backup")
      puts "✱ Restored #{linkable}"
      `mv "$HOME/backups/.#{linkable}.backup" "$HOME/.#{linkable}"` 
    end
  end

  puts "✱ Removing Janus"
  `rm ~/.vimrc ~/.gvimrc ~/.vim`

  puts "✱ Removing oh-my-zsh"
  `rm ~/.oh-my-zsh`

  puts "⚑ You may want to switch the shell back to bash (sudo chsh -s /bin/bash)"
end

task :submodules do
  puts "✱ Updating submodules"
  `git submodule update --init --recursive`
end

task :default => 'install'
