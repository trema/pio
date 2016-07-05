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

      # rubocop:disable MethodLength
      def to_hex
        ethernet_header.to_hex + "\n" +
          [:hardware_type,
           :protocol_type,
           :hardware_length,
           :protocol_length,
           :operation,
           :sender_hardware_address,
           :sender_protocol_address,
           :target_hardware_address,
           :target_protocol_address].map do |each|
            __send__(each).to_hex + ", # #{each}"
          end.join("\n")
      end
      # rubocop:enable MethodLength
    end
  end
end
