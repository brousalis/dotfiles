# encoding: UTF-8

require 'rake'

task :install do
  linkables = Dir.glob('*').reject{|f| f["extra"] || f["README.md"]}

  skip_all = false
  overwrite_all = false
  backup_all = false

  puts "\n"

  if File.exists?("#{ENV["HOME"]}/.janus") || File.exists?("#{ENV["HOME"]}/.gvimrc")
    puts "!!! Janus is already installed, overwrite? [y]es or [n]o"
    case STDIN.gets.chomp
      when 'y' then 
        `curl -Lo- https://bit.ly/janus-bootstrap | bash`
    end 
  end

  puts "\n✱ Installing git bash completion"
  `curl https://raw.github.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash`

  puts "\n✱ Syncing gitmodules (mostly janus plugins)"
  `git submodule update --init`

  puts "\n✱ Symlinking dotfiles"
  linkables.each do |linkable|
    overwrite = false
    backup = false

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
    `ln -s "$PWD/#{linkable}" "#{target}"`
  end
end

task :uninstall do
  linkables = Dir.glob('*').reject{|f| f["janus"] || f["extra"] || f["README.md"]}

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
  
  puts "\n!!! Remove Janus? [y]es or [n]o"
  case STDIN.gets.chomp
    when 'y' then 
      puts "✱ Removing Janus"
      `rm ~/.vimrc ~/.gvimrc`
      `rm -rf ~/.janus`
    when 'n' then next
  end
end

task :default => 'install'
