require 'pio/open_flow'
require 'pio/parse_error'

module Pio
  module OpenFlow
    # OpenFlow message parser interface.
    # rubocop:disable AbcSize
    module Parser
      def read(raw_data)
        message_type =
          Pio::Type::OpenFlow::OpenFlowHeader.read(raw_data).message_type
        klass = Pio::OpenFlow::Message.klass(message_type)
        if klass.name.split('::')[0..-2].join('::') != name
          fail Pio::ParseError, "Invalid #{name.split('::').last} message."
        end
        klass.read(raw_data)
      rescue KeyError
        raise Pio::ParseError, 'Invalid OpenFlow message.'
      end
    end
    # rubocop:enable AbcSize
  end
end
