require 'bindata'
require 'forwardable'
require 'pio/monkey_patch/integer'
require 'pio/open_flow/port_number'

module Pio
  # An action to enqueue the packet on the specified queue attached to
  # a port.
  class Enqueue
    # OpenFlow 1.0 OFPAT_ENQUEUE action format.
    class Format < BinData::Record
      endian :big

      uint16 :type, value: 11
      uint16 :message_length, value: 16
      port_number :port_number
      uint48 :padding
      hide :padding
      uint32 :queue_id
    end

    def self.read(raw_data)
      enqueue = allocate
      enqueue.instance_variable_set :@format, Format.read(raw_data)
      enqueue
    end

    extend Forwardable

    def_delegators :@format, :type
    def_delegators :@format, :message_length
    def_delegators :@format, :port_number
    def_delegators :@format, :queue_id
    def_delegator :@format, :to_binary_s, :to_binary

    def initialize(user_options)
      validate_port_number user_options
      validate_queue_id user_options
      @format = Format.new(user_options)
    end

    private

    def validate_port_number(user_options)
      port_number = user_options.fetch(:port_number)
      if port_number.is_a?(Symbol) && port_number != :in_port
        fail(ArgumentError,
             ':port_number must be a valid physical port or :in_port')
      end
    rescue KeyError
      raise ArgumentError, ':port_number is a mandatory option'
    end

    def validate_queue_id(user_options)
      unless user_options.fetch(:queue_id).unsigned_32bit?
        fail ArgumentError, ':queue_id must be an unsigned 32-bit integer'
      end
    rescue KeyError
      raise ArgumentError, ':queue_id is a mandatory option'
    end
  end
end
