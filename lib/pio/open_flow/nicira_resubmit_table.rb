require 'pio/open_flow/nicira_action'

module Pio
  module OpenFlow
    # NXAST_RESUBMIT_TABLE action
    class NiciraResubmitTable < OpenFlow::NiciraAction
      nicira_action_header action_type: 0xffff,
                           action_length: 16,
                           subtype: 14
      uint16 :in_port
      uint8 :table, initial_value: 0xff
      string :padding, length: 3
      hide :padding

      def initialize(options)
        raise ':in_port option is a mandatory' unless options.key?(:in_port)
        super options
      end
    end
  end
  NiciraResubmitTable = OpenFlow::NiciraResubmitTable
end
