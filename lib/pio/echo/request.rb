require 'forwardable'
require 'pio/echo/message'

module Pio
  # OpenFlow Echo Request and Reply message parser.
  class Echo
    # OpenFlow 1.0 Echo Request message.
    class Request
      extend Forwardable

      def_delegators :@echo, :version
      def_delegators :@echo, :message_type
      def_delegators :@echo, :message_length
      def_delegators :@echo, :xid
      def_delegators :@echo, :data

      def self.create_from(echo)
        message = allocate
        message.instance_variable_set :@echo, echo
        message
      end

      def initialize
        @echo = Message.new(message_type: REQUEST)
      end
    end
  end
end
