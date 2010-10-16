require 'pp'
require 'rubygems'
require 'open-uri'
require 'json'

# completion
require 'irb/completion'

# history
require 'irb/ext/save-history'
IRB.conf[:USE_READLINE] = true
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_PATH] = File::expand_path("~/.irb.history")

# refe
require 'nkf'
module Kernel
  def r(arg)
    puts NKF.nkf('-w', `refe #{arg}`)
  end
  private :r
end

class Module
  def r(meth = nil)
    if meth
      if instance_methods(false).include? meth.to_s
        puts `refe #{self}##{meth}`
      else
        super
      end
    else
      puts NKF.nkf('-w', `refe #{self}`)
    end
  end
end
