require 'pio/open_flow/flags'

module Pio
  module OpenFlow10
    class Features
      # OpenFlow 1.0 Features Reply message.
      class Reply < OpenFlow::Message
        extend OpenFlow::Flags

        # enum ofp_capabilities
        flags_32bit :capabilities,
                    [:flow_stats,
                     :table_stats,
                     :port_stats,
                     :stp,
                     :reserved,
                     :ip_reasm,
                     :queue_stats,
                     :arp_match_ip]
      end
    end
  end
end
