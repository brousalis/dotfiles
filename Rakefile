# encoding: UTF-8

require 'rake'

task :install do
  linkables = Dir.glob('*').reject{|f| f["extra"] || f["README.md"]}

  skip_all = false
  overwrite_all = false
  backup_all = false

  puts "\n✱ Syncing submodules"
  `git submodule sync >/dev/null`
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
 end

# thanks mislav
task :update_submodules do
  system <<-EOS
    git submodule foreach '
      rev=$(git rev-parse HEAD)
      git pull --quiet --ff-only --no-rebase origin master &&
      git --no-pager log --no-merges --pretty=format:"%s %Cgreen(%ar)%Creset" --date=relative ${rev}..
      echo
    '
  EOS
end

task :default => 'install'
