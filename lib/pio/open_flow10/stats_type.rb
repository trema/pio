module Pio
  module OpenFlow10
    # enum ofp_stats_types
    class StatsType < BinData::Primitive
      STATS_TYPES = {
        description: 0,
        flow: 1,
        aggregate: 2,
        table: 3,
        port: 4,
        queue: 5,
        vendor: 0xffff
      }

      endian :big
      uint16 :command

      def get
        STATS_TYPES.invert.fetch(command)
      end

      def set(value)
        self.command = STATS_TYPES.fetch(value)
      end
    end
  end
end
