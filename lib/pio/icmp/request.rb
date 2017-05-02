# frozen_string_literal: true

require 'pio/icmp/message'

module Pio
  class Icmp
    # ICMP Request packet generator
    class Request < Message
      option :icmp_type, value: 8
      option :source_mac
      option :destination_mac
      option :source_ip_address
      option :destination_ip_address
      option :icmp_identifier, default: 0
      option :icmp_sequence_number, default: 0
      option :echo_data, default: ''
    end
  end
end
