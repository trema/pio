require 'pio/open_flow/flags'

module Pio
  module OpenFlow10
    # Features Request and Reply message.
    class Features
      # OpenFlow 1.0 Features Reply message.
      class Reply < OpenFlow::Message
        extend OpenFlow::Flags

        # enum ofp_action_type
        flags_32bit :actions_flag,
                    [:output,
                     :set_vlan_vid,
                     :set_vlan_pcp,
                     :strip_vlan,
                     :set_source_mac_address,
                     :set_destination_mac_address,
                     :set_source_ip_address,
                     :set_destination_ip_address,
                     :set_tos,
                     :set_transport_source_port,
                     :set_transport_destination_port,
                     :enqueue]
      end
    end
  end
end
