require 'bindata'
require 'forwardable'
require 'pio/monkey_patch/integer'
require 'pio/open_flow10/port16'

module Pio
  # An action to enqueue the packet on the specified queue attached to
  # a port.
  class Enqueue
    # OpenFlow 1.0 OFPAT_ENQUEUE action format.
    class Format < BinData::Record
      endian :big

      uint16 :action_type, value: 11
      uint16 :action_length, value: 16
      port16 :port
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

    def_delegators :@format, :action_type
    def_delegator :@format, :action_length, :length
    def_delegators :@format, :port
    def_delegators :@format, :queue_id
    def_delegator :@format, :to_binary_s, :to_binary

    def initialize(user_options)
      validate_port user_options
      validate_queue_id user_options
      @format = Format.new(user_options)
    end

    private

    def validate_port(user_options)
      port = user_options.fetch(:port)
      if port.is_a?(Symbol) && port != :in_port
        fail(ArgumentError,
             ':port must be a valid physical port or :in_port')
      end
    rescue KeyError
      raise ArgumentError, ':port is a mandatory option'
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
