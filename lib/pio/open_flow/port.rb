module Pio
  module OpenFlow
    # Port numbering.
    class Port < BinData::Primitive
      endian :big

      def self.port_size_in_bytes(nbytes)
        class_eval "uint#{nbytes} :port"
      end

      def self.max_port_number(port_number)
        const_set :MAX, port_number
      end

      def self.reserved_ports(port_name_and_number)
        @reserved = port_name_and_number
      end

      def self.reserved_port_number(port_name)
        @reserved.fetch port_name
      end

      def self.reserved_port_name?(port_name)
        @reserved.key? port_name
      end

      def max
        self.class.const_get :MAX
      end

      def reserved_port_number(port_name)
        self.class.reserved_port_number port_name
      end

      def reserved_port_name?(port_name)
        self.class.reserved_port_name? port_name
      end

      def reserved_port_number?(port_number)
        self.class.instance_variable_get(:@reserved).invert.key?(port_number)
      end

      def reserved_port_name(port_number)
        self.class.instance_variable_get(:@reserved).invert.fetch(port_number)
      end

      def get
        if reserved_port_number?(port)
          reserved_port_name(port)
        else
          port
        end
      end

      def set(port)
        if reserved_port_name?(port)
          self.port = reserved_port_number(port)
        else
          port_num = port.to_i
          fail ArgumentError, 'The port should be > 0' if port_num < 1
          if port_num >= max
            fail ArgumentError, "The port should be < #{max.to_hex}"
          end
          self.port = port_num
        end
      end
    end
  end
end
