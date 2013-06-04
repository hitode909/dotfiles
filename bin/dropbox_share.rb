#!/usr/bin/env ruby

require 'digest/md5'
require 'fileutils'
require 'open-uri'

def upload(source_path)
  name = Digest::MD5.hexdigest Time.now.to_f.to_s

  extname = File.extname(source_path)

  dest_path = File.expand_path "~/Dropbox/Public/g/#{name}#{extname}"

  FileUtils.mv(source_path, dest_path)

  url = 'http://dl.dropbox.com/u/8270034/g/' + File.basename(dest_path)

  puts url

  retries = 0
  begin
    open(url) if retries < 20
  rescue
    retries += 1
    sleep 0.3
    retry
  end

  system "open #{url}"
end

ARGV.each{ |path|
  upload path
}

