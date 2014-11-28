# encoding: utf-8

require 'English'
require 'forwardable'
require 'pio/hello/format'

module Pio
  # OpenFlow 1.0 Hello message
  class Hello
    extend Forwardable

    def_delegators :@format, :ofp_version
    def_delegators :@format, :message_type
    def_delegators :@format, :message_length
    def_delegators :@format, :transaction_id
    def_delegator :@format, :transaction_id, :xid
    def_delegators :@format, :body
    def_delegator :@format, :to_binary_s, :to_binary

    # Parses +raw_data+ binary string into a Hello message object.
    #
    # @example
    #   Pio::Hello.read("\x01\x00\x00\b\x00\x00\x00\x00")
    # @return [Pio::Hello]
    def self.read(raw_data)
      hello = allocate
      begin
        hello.instance_variable_set :@format, Format.read(raw_data)
      rescue BinData::ValidityError
        raise ParseError, $ERROR_INFO.message
      end
      hello
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
      @format = Format.new(options)
    end
  end
end
