require 'pio/open_flow/action'

module Pio
  module OpenFlow
    # NXAST_* actions
    class NiciraAction < Action
      def self.nicira_action_header(options)
        module_eval do
          action_header action_type: options.fetch(:action_type),
                        action_length: options.fetch(:action_length)
          uint32 :vendor, value: 0x2320
          uint16 :subtype, value: options.fetch(:subtype)
        end
      end
    end
  end
end
