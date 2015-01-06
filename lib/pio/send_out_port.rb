require 'bindata'
require 'forwardable'
require 'pio/monkey_patch/integer'

module Pio
  # An action to output a packet to a port.
  class SendOutPort
    # OpenFlow 1.0 OFPAT_OUTPUT action format.
    class Format < BinData::Record
      endian :big

      uint16 :type, value: 0
      uint16 :message_length, value: 8
      port_number :port_number
      uint16 :max_len, initial_value: 2**16 - 1
    end

    def self.read(raw_data)
      send_out_port = allocate
      send_out_port.instance_variable_set :@format, Format.read(raw_data)
      send_out_port
    end

    extend Forwardable

    def_delegators :@format, :message_length
    def_delegators :@format, :port_number
    def_delegators :@format, :max_len
    def_delegator :@format, :to_binary_s, :to_binary

    # Creates an action to output a packet to a port.
    #
    # @example
    #   SendOutPort.new(1)
    #   SendOutPort.new(port_number: 1)
    #   SendOutPort.new(port_number: :controller, max_len: 256)
    #
    # @param [Integer|Hash] user_options
    #   the port number or the options hash to create this action
    #   class instance with.
    #
    # @option user_options [Number] :port_number
    #   port number an index into switch's physical port list. There
    #   are also fake output ports. For example a port number set to
    #   +:flood+ would output packets to all physical ports except
    #   input port and ports disabled by STP.
    # @option user_options [Number] :max_len
    #   the maximum number of bytes from a packet to send to
    #   controller when port is set to +:controller+. A zero length
    #   means no bytes of the packet should be sent. It defaults to
    #   64K.
    #
    # @raise [ArgumentError] if +:port_number+ is not an unsigned
    #                        16-bit integer.
    # @raise [ArgumentError] if +:max_len+ is not an unsigned 16-bit integer.
    #
    # rubocop:disable MethodLength
    def initialize(user_options)
      options = if user_options.respond_to?(:to_i)
                  { port_number: user_options.to_i }
                elsif PortNumber::NUMBERS.key?(user_options)
                  { port_number: user_options }
                else
                  user_options
                end
      max_len = options[:max_len]
      if max_len && !max_len.unsigned_16bit?
        fail ArgumentError, 'The max_len should be an unsigned 16bit integer.'
      end
      @format = Format.new(options)
    end
    # rubocop:enable MethodLength
  end
end
