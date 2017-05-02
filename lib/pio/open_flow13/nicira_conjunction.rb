# frozen_string_literal: true

require 'pio/open_flow/nicira_action'

module Pio
  module OpenFlow13
    # NXAST_CONJUNCTION action
    class NiciraConjunction < OpenFlow::NiciraAction
      nicira_action_header action_type: 0xffff,
                           action_length: 16,
                           subtype: 34
      uint8 :_clause
      uint8 :n_clauses
      uint32 :conjunction_id

      def initialize(options)
        super(_clause: options[:clause] - 1,
              n_clauses: options[:n_clauses],
              conjunction_id: options[:conjunction_id])
      end

      def clause
        _clause + 1
      end
    end
  end
  NiciraConjunction = OpenFlow13::NiciraConjunction
end
