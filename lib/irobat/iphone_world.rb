require File.dirname(__FILE__) + '/phone_driver'

module IRobat
  module IPhoneWorld
    def self.method_missing(method, *args)
      @phone ||= PhoneDriver.new
    
      @phone.send(method, *args)
    end

    def self.touch_table_row(field, value)
      simulate_touch ['className', 'UITableViewCell', field, value]
    end

    def self.touch_button(field, value)
      simulate_touch ['className', 'UIRoundedRectButton', field, value]
      
    end
  end
end
