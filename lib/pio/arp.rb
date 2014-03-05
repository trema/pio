# -*- coding: utf-8 -*-
require 'English'
require 'pio/arp/frame'
require 'pio/arp/request'
require 'pio/arp/reply'

module Pio
  # ARP parser and generator.
  class Arp
    MESSAGE_TYPE = {
      Request::OPERATION => Request,
      Reply::OPERATION => Reply
    }

    def self.read(raw_data)
      begin
        frame = Frame.read(raw_data)
      rescue
        raise Pio::ParseError, $ERROR_INFO.message
      end

      MESSAGE_TYPE[frame.message_type].create_from frame
    end
  end
end

### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
