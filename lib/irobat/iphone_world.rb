require File.dirname(__FILE__) + '/phone_driver'

module IRobat
  module IPhoneWorld
    def self.method_missing(method, *args)
      @phone ||= PhoneDriver.new

      @phone.send(method, *args)
    end

    def self.touch_table_row(value, field = 'text')
      simulate_touch ['className', 'UITableViewCell', field, value]
    end

    def self.touch_button(value, field = 'currentTitle')
      simulate_touch ['className', 'UIRoundedRectButton', field, value]
    end

    def self.check_label_contains(value, field = 'text')
      check_match_count ['className', 'UILabel', field, value],['matchCount', 1]
    end
  end
end
