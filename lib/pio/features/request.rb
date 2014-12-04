# encoding: utf-8

require 'forwardable'
require 'pio/features/message'
require 'pio/open_flow'

module Pio
  # OpenFlow 1.0 Features messages
  class Features
    # OpenFlow 1.0 Features Request message
    class Request < Pio::OpenFlow::Message
      # OpenFlow 1.0 Features Request format
      class Format < BinData::Record
        include Pio::OpenFlow::Type

        endian :big

        open_flow_header :open_flow_header, message_type_value: FEATURES_REQUEST
        virtual assert: -> { open_flow_header.message_type == FEATURES_REQUEST }

        string :body
      end

      include Pio::OpenFlow::Type

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
      #
      # rubocop:disable Metrics/MethodLength
      def initialize(user_options = {})
        if user_options.respond_to?(:to_i)
          @options = { transaction_id: user_options.to_i,
                       message_type_value: FEATURES_REQUEST }
        elsif user_options.respond_to?(:[])
          @options =
            user_options.dup.merge(message_type_value: FEATURES_REQUEST)
          handle_user_hash_options
        else
          fail TypeError
        end
        @format = Format.new(@options)
        @format.open_flow_header.assign(@options)
      end
      # rubocop:enable Metrics/MethodLength

      private

      def handle_user_hash_options
        @options[:transaction_id] ||= @options[:xid]
        @options[:transaction_id] = 0 unless @options[:transaction_id]
      end
    end
  end
end
