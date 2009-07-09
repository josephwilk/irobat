$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'cucumber'

require 'irobat/phone'
require 'irobat/phone_driver'
require 'irobat/iphone_world'

module IRobat
  SERVER_DIR = File.dirname(__FILE__) + '/server/'

  def self.startup_iphone_coordinators
    puts "Starting iphone instructor..."
    Kernel.fork {`cd #{SERVER_DIR};ruby instructor.rb -p 3001 2> /dev/null`}
    puts "Starting iphone receiver..."
    Kernel.fork {`cd #{SERVER_DIR};ruby receiver.rb -p 3000 2> /dev/null`}
    sleep(2)
  end
  
  def self.shutdown_iphone_coach
    Curl::Easy.http_post 'http://localhost:3001/', 'q=' + CGI.escape(Phone::Command.empty)
  end
  
end

IRobat.startup_iphone_coordinators

at_exit {
  IRobat.shutdown_iphone_coach
}  
