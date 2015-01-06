require 'forwardable'
require 'pio/open_flow'

module Pio
  # OpenFlow 1.0 Features messages
  class Features
    # OpenFlow 1.0 Features Request message
    class Request < Pio::OpenFlow::Message
      # Message body of Features Request
      class Body < BinData::Record
        endian :big

        string :body # ignored

        def length
          0
        end

        def empty?
          true
        end
      end

      def_format Pio::OpenFlow::Type::FEATURES_REQUEST

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
      # rubocop:disable MethodLength
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
        if options[:open_flow_header][:transaction_id] >= 2**32
          fail ArgumentError, 'Transaction ID >= 2**32'
        end
        @format = Format.new(options)
      end
      # rubocop:enable MethodLength
    end
  end
end
