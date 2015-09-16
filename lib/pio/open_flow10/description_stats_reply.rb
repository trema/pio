require 'pio/open_flow10/stats_type'

# Base module.
module Pio
  # OpenFlow 1.0 messages
  module OpenFlow10
    # OpenFlow 1.0 Description Stats messages
    module DescriptionStats
      # OpenFlow 1.0 Description Stats Reply message
      class Reply < OpenFlow::Message
        # Message body of Flow Stats Reply.
        class Body < BinData::Record
          endian :big

          stats_type :stats_type, value: -> { :description }
          uint16 :flags

          stringz :manufacturer, length: 256
          stringz :hardware, length: 256
          stringz :software, length: 256
          stringz :serial_number, length: 32
          stringz :datapath, length: 256
        end

        # OpenFlow 1.0 Description Stats Reply message format.
        class Format < BinData::Record
          extend OpenFlow::Format

          header version: 1, message_type: 17
          body :body
        end
      end
    end
  end
end
