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

        def body
          ''
        end
      end

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
      # @reek This method smells of :reek:FeatureEnvy
      def initialize(user_options = {})
        options = if user_options.respond_to?(:to_i)
                    { open_flow_header: { transaction_id: user_options.to_i } }
                  elsif user_options.respond_to?(:fetch)
                    transaction_id =
                      user_options[:transaction_id] || user_options[:xid] || 0
                    { open_flow_header: { transaction_id: transaction_id } }
                  else
                    fail TypeError
                  end
        @format = Format.new(options)
      end
    end
  end
end
