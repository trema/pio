# frozen_string_literal: true

require 'pio/arp/message'
require 'pio/instance_inspector'
require 'pio/mac'

module Pio
  class Arp
    # ARP Reply packet generator
    class Reply < Message
      include InstanceInspector

      option :operation, value: 2
      option :source_mac
      option :destination_mac
      option :sender_hardware_address, value: :source_mac
      option :target_hardware_address, value: :destination_mac
      option :sender_protocol_address
      option :target_protocol_address
    end
  end
end
