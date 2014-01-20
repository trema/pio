# -*- coding: utf-8 -*-
module Pio
  module Type
    # UDP Header Format.
    module UdpHeader
      def udp_header(options)
        endian :big
        class_eval do
          uint16be :udp_src_port
          uint16be :udp_dst_port
          uint16be :udp_length, :initial_value => options[:udp_length]
          uint16be :udp_checksum, :initial_value => options[:udp_checksum]
        end
      end
    end
  end
end

### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
