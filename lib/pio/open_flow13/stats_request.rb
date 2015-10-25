require 'pio/open_flow'

module Pio
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

      open_flow_header version: 4,
                       message_type: 16,
                       message_length: 12
      stats_type :stats_type
      uint16 :stats_flags
    end
  end
end
