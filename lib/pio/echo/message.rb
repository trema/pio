require 'forwardable'
require 'bindata'

module Pio
  class Echo
    # Base class of Echo request and reply.
    class Message
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
    end
  end
end
