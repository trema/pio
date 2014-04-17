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
        if user_options.respond_to?(:to_i)
          @options = { transaction_id: user_options.to_i,
                       message_type: message_type }
        elsif user_options.respond_to?(:[])
          @options = user_options.dup.merge(message_type: message_type)
          handle_user_hash_options
        else
          fail TypeError
        end
        @echo = Format.new(@options)
      end

      private

      def handle_user_hash_options
        @options[:transaction_id] ||= @options[:xid]
        @options[:transaction_id] = 0 unless @options[:transaction_id]
      end
    end
  end
end
