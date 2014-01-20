# -*- coding: utf-8 -*-

module Pio
  class Dhcp
    # Checksum Calculate Utility.
    module CsumUtil

      private

      def ip_csum
        ipv4_header_2bytewise_slices.reduce(:+)
      end

      def udp_csum
        udp_header_2bytewise_slices.reduce(:+)
      end

      def ipv4_header_2bytewise_slices
        [
         ipversion_ipheaderlength_iptypeofservice, ip_total_length,
         ip_identifier, ipflag_ipfragment,
         ipttl_ipproto,
         ip_source_address_upper,
         ip_source_address_lower,
         ip_destination_address_upper,
         ip_destination_address_lower
        ]
      end

      def ip_source_address_upper
        ip_source_address.get.to_i >> 16
      end

      def ip_source_address_lower
        ip_source_address.get.to_i & 0xffff
      end

      def ip_destination_address_upper
        ip_destination_address.get.to_i >> 16
      end

      def ip_destination_address_lower
        ip_destination_address.get.to_i & 0xffff
      end

      def ipversion_ipheaderlength_iptypeofservice
        ip_version << 12 | ip_header_length << 8 | ip_type_of_service
      end

      def ipflag_ipfragment
        ip_flag << 13 | ip_fragment
      end

      def ipttl_ipproto
        ip_ttl << 8 | ip_protocol
      end

      def udp_header_2bytewise_slices
        [
          pseudo_header_2bytewise_slices,
          udp_src_port,
          udp_dst_port,
          udp_len,
          payload_2bytewise_slices
        ]
      end

      def payload_2bytewise_slices
        (dhcp.to_binary_s + trail_data).unpack('n*').reduce(:+)
      end

      def pseudo_header_2bytewise_slices
        [
          ip_source_address_upper,
          ip_source_address_lower,
          ip_destination_address_upper,
          ip_destination_address_lower,
          ip_protocol,
          udp_len,
        ].pack('n*').unpack('n*').reduce(:+)
      end
    end
  end
end

### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
