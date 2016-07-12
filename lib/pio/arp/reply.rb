require 'pio/arp/message'
require 'pio/instance_inspector'
require 'pio/mac'

module Pio
  class Arp
    # ARP Reply packet generator
    class Reply < Message
      include InstanceInspector

      options operation: 2,
              source_mac: :source_mac,
              destination_mac: :destination_mac,
              sender_hardware_address: :source_mac,
              target_hardware_address: :destination_mac,
              sender_protocol_address: :sender_protocol_address,
              target_protocol_address: :target_protocol_address
    end
  end
end
