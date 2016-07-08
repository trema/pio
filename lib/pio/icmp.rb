require 'pio/icmp/format'
require 'pio/icmp/reply'
require 'pio/icmp/request'

# Packet parser and generator library.
module Pio
  # Icmp parser and generator.
  class Icmp
    def self.read(raw_data)
      format = Format.read(raw_data)
      message = { Request::TYPE => Request,
                  Reply::TYPE => Reply }.fetch(format.icmp_type).allocate
      message.instance_variable_set :@format, format
      message
    rescue
      raise Pio::ParseError, $ERROR_INFO.message
    end
  end
  ICMP = Icmp
end
