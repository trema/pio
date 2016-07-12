require 'pio/arp/format'
require 'pio/arp/reply'
require 'pio/arp/request'
require 'pio/parse_error'

# Packet parser and generator library.
module Pio
  # ARP parser and generator.
  class Arp
    def self.read(raw_data)
      format = Format.read(raw_data)
      { Request.operation => Request,
        Reply.operation => Reply }.fetch(format.operation).create(format)
    rescue
      raise Pio::ParseError, $ERROR_INFO.message
    end
  end
end
