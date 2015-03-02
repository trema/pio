require 'pio/icmp/format'

module Pio
  class Icmp
    # Base class of Icmp::Request and Icmp::Reply.
    class Message
      private_class_method :new

      def initialize(user_options)
        options = self.class.const_get(:Options).new(user_options)
        @format = Icmp::Format.new(options.to_hash)
      end

      def method_missing(method, *args)
        @format.__send__(method, *args)
      end
    end
  end
end
