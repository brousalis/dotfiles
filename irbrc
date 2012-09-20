require 'irb/completion'
require 'irb/ext/save-history'
require 'rubygems'
require 'pp'

begin
  require 'ap'
rescue LoadError
  puts "*** awesome_print disabled ***"
  require 'pp'
end

begin
  require 'hirb'
  Hirb.enable
  extend Hirb::Console
rescue LoadError
  puts "*** hirb disabled ***"
end

IRB.conf[:AUTO_INDENT] = true
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"
IRB.conf[:PROMPT_MODE] = :SIMPLE

def clear
  system 'clear'
end
alias c clear
alias q exit

def IRB.reload
  load __FILE__
end
