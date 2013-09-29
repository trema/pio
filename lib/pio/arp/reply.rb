require "forwardable"
require "pio/arp/message"
require "pio/mac"


module Pio
  class Arp
    # ARP Reply packet generator
    class Reply < Message
      OPERATION = 2


      ##########################################################################
      private
      ##########################################################################


      def default_options
        {
          :operation => OPERATION,
        }
      end


      def user_options
        @options.merge(
          {
            :sender_hardware_address => @options[ :source_mac ],
            :target_hardware_address => @options[ :destination_mac ]
          }
        )
      end


      def mandatory_options
        [
          :source_mac,
          :destination_mac,
          :sender_hardware_address,
          :target_hardware_address,
          :sender_protocol_address,
          :target_protocol_address,
        ]
      end
    end
  end
end


### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
