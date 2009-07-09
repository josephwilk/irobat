require 'curb'
require 'cgi'
require 'spec/expectations'

module IRobat
  class PhoneDriver
    def initialize
      @curl = Curl::Easy.new 'http://localhost:3001/'
    end

    def method_missing(name, *args, &block)
      command = name.to_s.gsub(/_([a-z0-9])/) {$1.capitalize}
      xpath = Phone::Dict.new(args.shift).to_xpath
      extras = args.shift || []

      xml = Phone::Command.new(
        command,
        ['viewXPath', xpath] + extras).to_xml

      @curl.http_post 'q=' + CGI.escape(xml)
      @curl.body_str.strip.should == 'pass'
    end
  end
end
