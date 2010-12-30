#!/usr/bin/env ruby
require 'pathname'

def path_diff from, to
  Pathname.new(to).relative_path_from(Pathname.new(from)).to_s
end

def path_from_home path
  path.gsub(ENV['HOME'], '~')
end

unless ARGV.length == 2
  warn "usage: path_diff_ruby PATH1 PATH2"
  exit 1
end

from, to = *ARGV

puts [path_diff(from, to), path_from_home(to), to].sort_by(&:length).first
