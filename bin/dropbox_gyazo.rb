#!/usr/bin/env ruby

require 'fileutils'
require 'digest/md5'
require 'open-uri'

file = File.expand_path "~/Dropbox/Public/g/#{Digest::MD5.hexdigest(Time.now.to_f.to_s)}.png"
url = 'http://dl.dropbox.com/u/8270034/g/' + File.basename(file)

FileUtils.mkdir_p File.dirname(file)

system "screencapture -i \"#{file}\""
if File.exist?(file) then
  system "sips -d profile --deleteColorManagementProperties \"#{file}\""
else
  exit
end

retries = 0
begin
  open(url) if retries < 20
rescue
  retries += 1
  sleep 0.3
  retry
end

system "open #{url}"
