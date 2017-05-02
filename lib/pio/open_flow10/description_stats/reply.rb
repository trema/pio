# frozen_string_literal: true

require 'pio/open_flow10/stats_type'

module Pio
  module OpenFlow10
    # OpenFlow 1.0 Description Stats messages
    module DescriptionStats
      # OpenFlow 1.0 Description Stats Reply message
      class Reply < OpenFlow::Message
        open_flow_header version: 1, type: 17, length: 1068
        stats_type :stats_type, value: -> { :description }
        uint16 :flags

        stringz :manufacturer, length: 256
        stringz :hardware, length: 256
        stringz :software, length: 256
        stringz :serial_number, length: 32
        stringz :datapath, length: 256
      end
    end
  end
end
