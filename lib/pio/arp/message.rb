# frozen_string_literal: true

require 'pio/arp/format'
require 'pio/message'

module Pio
  class Arp
    # Base class of ARP Request and Reply
    class Message < Pio::Message
      def self.create(format)
        allocate.tap do |message|
          message.instance_variable_set :@format, format
        end
      end

      def initialize(user_options)
        @format = Arp::Format.new(parse_options(user_options))
      end

      def method_missing(method, *args)
        @format.__send__ method, *args
      end
    end
  end
end
