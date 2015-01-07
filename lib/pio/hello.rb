require 'pio/open_flow'

module Pio
  # OpenFlow 1.0 Hello message
  class Hello < OpenFlow::Message.factory(Pio::OpenFlow::Type::HELLO)
    # Creates a Hello OpenFlow message.
    #
    # @overload initialize()
    #   @example
    #     Pio::Hello.new
    #
    # @overload initialize(transaction_id)
    #   @example
    #     Pio::Hello.new(123)
    #   @param [Number] transaction_id
    #     An unsigned 32-bit integer number associated with this
    #     message.
    #
    # @overload initialize(user_options)
    #   @example
    #     Pio::Hello.new(transaction_id: 123)
    #     Pio::Hello.new(xid: 123)
    #   @param [Hash] user_options The options to create a message with.
    #   @option user_options [Number] :transaction_id
    #   @option user_options [Number] :xid An alias to transaction_id.
  end
end
