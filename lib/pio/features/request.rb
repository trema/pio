require 'pio/open_flow'

module Pio
  # OpenFlow 1.0 Features messages
  class Features
    # OpenFlow 1.0 Features Request message
    class Request < OpenFlow::Message.factory(OpenFlow::Type::FEATURES_REQUEST)
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
    end
  end
end
