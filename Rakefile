# encoding: UTF-8

require 'rake'

task :brew do
  if !File.exists?("/usr/local/Cellar")
    `ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"`
  end
  `brew bundle`
end

task :install do
  linkables = Dir['home/*'] + ['janus']
  username = `whoami`.strip

  skip_all = false
  overwrite_all = false
  backup_all = false

  unless File.exists?("/Users/#{username}/.vim/bootstrap.sh")
    puts "✱ Installing Janus"
    `curl -Lo- https://bit.ly/janus-bootstrap | bash`
  end

  puts "✱ Syncing gitmodules (janus plugins)"
  `git submodule update --init`

  puts "\n✱ Symlinking dotfiles"
  Dir.glob('home/*').each do |linkable|
    overwrite = false
    backup = false
    linkable = linkable.sub('home/','')
    target = "#{ENV["HOME"]}/.#{linkable}"

    if File.exists?(target) || File.symlink?(target)
      unless skip_all || overwrite_all || backup_all
        puts "!!! File already exists: #{target}"
        puts "!!! What do you want to do? [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all"
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
    `ln -s "$PWD/home/#{linkable}" "#{target}"`
  end

  unless Dir.exists?("/Users/#{username}/.janus")
    `mkdir ~/.janus`
  end

  puts "\n✱ Symlinking vim plugins"
  Dir.glob('janus/*').each do |linkable|
    linkable = linkable.sub('janus/','')
    target = "#{ENV["HOME"]}/.janus/#{linkable}"
    puts "✱ Linked #{target}"
    `ln -s "$PWD/janus/#{linkable}" "#{target}"`
  end
end

task :uninstall do
  linkables = Dir.glob('home/*')

  linkables.each do |linkable|
    linkable = linkable.sub('home/','')
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

  puts "✱ Removed janus plugins"
  `rm -rf ~/.janus`
 end

task :default => [:brew, :install]
