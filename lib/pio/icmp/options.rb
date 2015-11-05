require 'pio/options'

module Pio
  class Icmp
    # User options for creating an ICMP messages.
    class Options < Pio::Options
      def to_hash
        {
          icmp_type: @type,
          source_mac: @source_mac,
          destination_mac: @destination_mac,
          source_ip_address: @source_ip_address,
          destination_ip_address: @destination_ip_address,
          icmp_identifier: @identifier,
          icmp_sequence_number: @sequence_number,
          echo_data: @echo_data
        }.freeze
      end
    end
  end
end
