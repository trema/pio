require 'pio/arp/format'

module Pio
  class Arp
    # Base class of ARP Request and Reply
    class Message
      private_class_method :new

      def initialize(user_options)
        options = self.class.const_get(:Options).new(user_options.dup.freeze)
        @format = Arp::Format.new(options.to_hash)
      end

      def method_missing(method, *args)
        @format.__send__ method, *args
      end

      # Returns a Ruby code representation of this packet, such that
      # it can be eval'ed and sent later.
      def to_ruby
        hexes = @format.field_names.map do |each|
          '  ' + __send__(each).to_hex + ", # #{each}" if __send__("#{each}?")
        end.compact
        ['[', *hexes, "].pack('C*')"].join("\n")
      end
    end
  end
end
