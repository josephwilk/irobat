require 'rubygems'
require 'sinatra'
require 'fileutils'

post '/' do
  FileUtils.rm '/tmp/result.txt' rescue nil
  File.open('/tmp/step.txt', 'w') {|f| f.puts params['q']}
  sleep 0.2 until File.exists? '/tmp/result.txt'
  File.open('/tmp/result.txt', 'r') {|f| f.read}
end
