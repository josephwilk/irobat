require 'rubygems'
require 'sinatra'
require 'fileutils'

get '/' do
  sleep 0.2 until File.exists? '/tmp/step.txt'
  File.open('/tmp/step.txt', 'r') {|f| f.read}
end

get %r{/(.+)} do
  result = params[:captures].first
  FileUtils.rm '/tmp/step.txt' rescue nil
  File.open('/tmp/result.txt', 'w') {|f| f.puts result}
end
