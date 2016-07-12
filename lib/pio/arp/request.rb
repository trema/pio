require 'pio/arp/message'
require 'pio/instance_inspector'
require 'pio/mac'

module Pio
  class Arp
    # ARP Request packet generator
    class Request < Message
      include InstanceInspector

      options operation: 1,
              source_mac: :source_mac,
              destination_mac: 'ff:ff:ff:ff:ff:ff'.freeze,
              sender_hardware_address: :source_mac,
              target_hardware_address: '00:00:00:00:00:00'.freeze,
              sender_protocol_address: :sender_protocol_address,
              target_protocol_address: :target_protocol_address
    end
  end
end
