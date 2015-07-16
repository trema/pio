require 'pio/open_flow'

module Pio
  # This module smells of :reek:UncommunicativeModuleName
  module OpenFlow13
    # OpenFlow 1.3 Stats Request message
    class StatsRequest < OpenFlow::Message
      # Request type of Stats Request message
      class StatsType < BinData::Primitive
        TYPES = [:description,
                 :flow,
                 :aggregate,
                 :table,
                 :port,
                 :queue,
                 :vendor]

        endian :big

        uint16 :stats_type

        def set(value)
          self.stats_type = TYPES.find_index(value)
        end

        def get
          TYPES[stats_type]
        end
      end

      # OpenFlow 1.3 Stats Request message body
      class Body < BinData::Record
        endian :big

        stats_type :stats_type
        uint16 :stats_flags

        def length
          4
        end
      end

      # OpenFlow 1.3 Stats Request message format
      class Format < BinData::Record
        extend OpenFlow::Format

        header version: 4, message_type: 16
        body :body
      end

      body_option :stats_type
    end
  end
end
