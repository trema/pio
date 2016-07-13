require 'pio/icmp/format'
require 'pio/icmp/reply'
require 'pio/icmp/request'
require 'pio/parse_error'

module Pio
  # Icmp parser and generator.
  class Icmp
    def self.read(raw_data)
      format = Format.read(raw_data)
      { Request.icmp_type => Request,
        Reply.icmp_type => Reply }.fetch(format.icmp_type).create(format)
    rescue
      raise Pio::ParseError, $ERROR_INFO.message
    end
  end
end
