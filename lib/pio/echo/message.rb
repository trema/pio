# encoding: utf-8

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
      def_delegator :@echo, :transaction_id, :xid
      def_delegators :@echo, :data
      def_delegator :@echo, :to_binary_s, :to_binary

      def self.create_from(echo)
        message = allocate
        message.instance_variable_set :@echo, echo
        message
      end
    end
  end
end
