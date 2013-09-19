require "rubygems"
require "bindata"

require "pio/arp/request"
require "pio/arp/reply"


module Pio
  # ARP parser and generator.
  class Arp
    ARP_MESSAGE_TYPE = { Request::OPERATION => Request, Reply::OPERATION => Reply }


    def self.read( raw_data )
      begin
        frame = Arp::Frame.read( raw_data )
      rescue
        raise Pio::ParseError, $!.message
      end

      ARP_MESSAGE_TYPE[ frame.operation ].create_from frame
    end
  end
end


### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
