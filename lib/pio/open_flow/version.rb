module Pio
  module OpenFlow
    # OpenFlow version
    class Version < BinData::Primitive
      VERSIONS = { 1 => :OpenFlow10, 4 => :OpenFlow13 }.freeze

      uint8 :version

      def get
        VERSIONS.fetch(version)
      end

      def set(value)
        self.version = VERSIONS.invert.fetch(value)
      end

      def to_bytes
        version.to_hex
      end
    end
  end
end
