# frozen_string_literal: true

require 'pio/class_inspector'
require 'pio/icmp/format'
require 'pio/instance_inspector'
require 'pio/message'
require 'pio/ruby_dumper'

module Pio
  class Icmp
    # Base class of Icmp::Request and Icmp::Reply.
    class Message < Pio::Message
      extend ClassInspector
      include InstanceInspector

      def self.fields
        Icmp::Format.fields
      end

      def self.create(format)
        allocate.tap do |message|
          message.instance_variable_set :@format, format
        end
      end

      def initialize(user_options)
        @format = Icmp::Format.new(parse_options(user_options))
      end

      def method_missing(method, *args)
        @format.__send__(method, *args)
      end
    end
  end
end
