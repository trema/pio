require 'English'
require 'pio/hello/format'
require 'pio/parse_error'
require 'pio/open_flow'

module Pio
  # OpenFlow 1.0 Hello message
  class Hello < Pio::OpenFlow::Message
    # Parses +raw_data+ binary string into a Hello message object.
    #
    # @example
    #   Pio::Hello.read("\x01\x00\x00\b\x00\x00\x00\x00")
    # @return [Pio::Hello]
    def self.read(raw_data)
      hello = allocate
      hello.instance_variable_set :@format, Format.read(raw_data)
      hello
    rescue BinData::ValidityError
      raise Pio::ParseError, $ERROR_INFO.message
    end

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
    #
    # @reek This method smells of :reek:FeatureEnvy
    def initialize(user_options = {})
      options = if user_options.respond_to?(:to_i)
                  { transaction_id: user_options.to_i }
                elsif user_options.respond_to?(:fetch)
                  { transaction_id: user_options[:transaction_id] ||
                                    user_options[:xid] || 0 }
                else
                  fail TypeError
                end
      @format = Format.new(open_flow_header: options)
    end
  end
end
