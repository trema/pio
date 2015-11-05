require 'pio/monkey_patch/integer'
require 'pio/open_flow/action'
require 'pio/open_flow10/port16'

module Pio
  module OpenFlow10
    # An action to enqueue the packet on the specified queue attached
    # to a port.
    class Enqueue < OpenFlow::Action
      action_header action_type: 11, action_length: 16
      port16 :port
      string :padding, length: 6
      hide :padding
      uint32 :queue_id

      def initialize(user_options)
        validate_port user_options
        validate_queue_id user_options
        super(user_options)
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
end
