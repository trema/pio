# -*- coding: utf-8 -*-
require 'pio/arp/frame'
require 'pio/arp/message'
require 'pio/arp/request/options'
require 'pio/mac'

module Pio
  class Arp
    # ARP Request packet generator
    class Request < Message
      def self.create_from(frame)
        message = allocate
        message.instance_variable_set :@frame, frame
        message
      end

      def initialize(options)
        @frame = Arp::Frame.new(Options.new(options).to_hash)
      end
    end
  end
end

### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
