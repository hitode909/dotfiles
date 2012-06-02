#! /usr/bin/env ruby

require 'optparse'

def replace(file, from, to)
  body = open(file).read

  open(file, 'w'){ |f|
    f.write(body.gsub(from, to))
  }
end

config = { }
parser = OptionParser.new {|opt|
  opt.on('-a from', '--from') { |v|
    config[:a] = v
  }
  opt.on('-b from', '--to') { |v|
    config[:b] = v
  }
  opt.parse!(ARGV)
}

ARGV.each{ |file|
  replace(file, config[:a], config[:b])
}


