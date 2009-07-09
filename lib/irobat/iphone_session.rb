module IRobat
  module IPhoneWorld
    def self.method_missing(method, *args)
      @phone ||= PhoneDriver.new
    
      @phone.send(method, *args)
    end
  end
end

World {IRobat::IPhoneWorld}
