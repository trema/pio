# frozen_string_literal: true

require 'pio/icmp/message'

module Pio
  class Icmp
    # ICMP Reply packet generator
    class Reply < Message
      option :icmp_type, value: 0
      option :source_mac
      option :destination_mac
      option :source_ip_address
      option :destination_ip_address
      option :icmp_identifier
      option :icmp_sequence_number
      option :echo_data, default: ''
    end
  end
end
