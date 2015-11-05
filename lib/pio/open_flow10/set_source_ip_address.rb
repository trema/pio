require 'pio/open_flow/action'
require 'pio/type/ip_address'

module Pio
  module OpenFlow10
    # An action to modify the IPv4 source address of a packet.
    class SetSourceIpAddress < OpenFlow::Action
      action_header action_type: 6, action_length: 8
      ip_address :ip_address

      def initialize(ip_address)
        super ip_address: ip_address
      end
    end
  end
end
