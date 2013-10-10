# http://blog.nicksieger.com/articles/2006/04/23/tweaking-irb
ARGV.concat ["--readline", "--prompt-mode", "simple"]

require 'irb/completion'
require 'irb/ext/save-history'
require 'rubygems'

begin
  require 'ap'
rescue LoadError
  puts "*** awesome_print disabled ***"
  require 'pp'
end

IRB.conf[:AUTO_INDENT] = true
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"
IRB.conf[:PROMPT_MODE] = :SIMPLE

# http://ozmm.org/posts/time_in_irb.html
def time(times = 1)
  require 'benchmark'
  ret = nil
  Benchmark.bm { |x| x.report { times.times { ret = yield } } }
  ret
end

def clear
  system 'clear'
end
alias c clear
alias q exit

def IRB.reload
  load __FILE__
end

