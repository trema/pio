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
      def_delegators :@echo, :transaction_id
      def_delegator :@echo, :transaction_id, :xid
      def_delegators :@echo, :data
      def_delegator :@echo, :to_binary_s, :to_binary

      def self.create_from(echo)
        message = allocate
        message.instance_variable_set :@echo, echo
        message
      end

      def initialize(message_type, user_options = {})
        @options = user_options.dup.merge(message_type: message_type)
        handle_option_aliases
        @echo = Format.new(@options)
      end

      private

      def handle_option_aliases
        @options[:transaction_id] ||= @options[:xid]
      end
    end
  end
end
