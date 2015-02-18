module Pio
  class Dhcp
    # Dhcp Field Read Methods.
    module FieldUtil
      def message_type
        get_tlv_field(53)
      end

      def server_identifier
        get_tlv_field(54)
      end

      def client_identifier
        get_tlv_field(61)
      end

      def renewal_time_value
        get_tlv_field(58)
      end

      def rebinding_time_value
        get_tlv_field(59)
      end

      def ip_address_lease_time
        get_tlv_field(51)
      end

      def requested_ip_address
        get_tlv_field(50)
      end

      def parameters_list
        get_tlv_field(55)
      end

      def subnet_mask
        get_tlv_field(1)
      end

      def hw_addr_type
        dhcp.hw_addr_type
      end

      def hw_addr_len
        dhcp.hw_addr_len
      end

      def hops
        dhcp.hops
      end

      def transaction_id
        dhcp.transaction_id
      end

      def seconds
        dhcp.seconds
      end

      def bootp_flags
        dhcp.bootp_flags
      end

      def client_ip_address
        dhcp.client_ip_address
      end

      def your_ip_address
        dhcp.your_ip_address
      end

      def next_server_ip_address
        dhcp.next_server_ip_address
      end

      def relay_agent_ip_address
        dhcp.relay_agent_ip_address
      end

      def client_mac_address
        dhcp.client_mac_address
      end

      private

      def get_tlv(tlv_type)
        tlv = dhcp.optional_tlvs.find do |each|
          each['tlv_type'] == tlv_type
        end
        tlv['tlv_value'] if tlv
      end

      def get_tlv_field(tlv_type)
        tlv = get_tlv(tlv_type)
        tlv.snapshot if tlv
      end
    end
  end
end
