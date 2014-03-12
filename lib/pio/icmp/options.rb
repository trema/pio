# -*- coding: utf-8 -*-
require 'pio/options'

module Pio
  class Icmp
    # User options for creating an ICMP messages.
    class Options < Pio::Options
      DEFAULT_ECHO_DATA = ''

      def to_hash
        {
         icmp_type: @type,
         source_mac: @source_mac,
         destination_mac: @destination_mac,
         ip_source_address: @ip_source_address,
         ip_destination_address: @ip_destination_address,
         icmp_identifier: @identifier,
         icmp_sequence_number: @sequence_number,
         echo_data: @echo_data
        }
      end
    end
  end
end

### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
