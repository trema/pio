# encoding: utf-8

require 'forwardable'
require 'pio/features/message'

module Pio
  # OpenFlow 1.0 Features messages
  class Features
    # OpenFlow 1.0 Features Request message
    class Request < Message
      extend Forwardable

      def_delegators :@features, :version
      def_delegators :@features, :message_type
      def_delegators :@features, :message_length
      def_delegators :@features, :transaction_id
      def_delegator :@features, :transaction_id, :xid
      def_delegators :@features, :body
      def_delegator :@features, :to_binary_s, :to_binary

      # Creates a Features Request OpenFlow message.
      #
      # @overload initialize()
      #   @example
      #     Pio::Features::Request.new
      #
      # @overload initialize(transaction_id)
      #   @example
      #     Pio::Features::Request.new(123)
      #   @param [Number] transaction_id
      #     An unsigned 32-bit integer number associated with this
      #     message.
      #
      # @overload initialize(user_options)
      #   @example
      #     Pio::Features::Request.new(transaction_id: 123)
      #     Pio::Features::Request.new(xid: 123)
      #   @param [Hash] user_options
      #     The options to create a message with.
      #   @option user_options [Number] :transaction_id
      #   @option user_options [Number] :xid An alias to transaction_id.
      def initialize(user_options = {})
        if user_options.respond_to?(:to_i)
          @options = { transaction_id: user_options.to_i,
                       message_type: 5 }
        elsif user_options.respond_to?(:[])
          @options = user_options.dup.merge(message_type: 5)
          handle_user_hash_options
        else
          fail TypeError
        end
        @features = Format.new(@options)
      end

      private

      def handle_user_hash_options
        @options[:transaction_id] ||= @options[:xid]
        @options[:transaction_id] = 0 unless @options[:transaction_id]
      end
    end
  end
end
