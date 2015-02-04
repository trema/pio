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
    end
  end
end
