require 'pio/arp/message'
require 'pio/instance_inspector'
require 'pio/mac'

module Pio
  class Arp
    # ARP Request packet generator
    class Request < Message
      include InstanceInspector

      option :operation, value: 1
      option :source_mac
      option :destination_mac, default: 'ff:ff:ff:ff:ff:ff'.freeze
      option :sender_hardware_address, value: :source_mac
      option :target_hardware_address, default: '00:00:00:00:00:00'.freeze
      option :sender_protocol_address
      option :target_protocol_address
    end
  end
end
