require 'pio/open_flow'

module Pio
  # OpenFlow 1.0 Echo Request and Reply message parser.
  module Echo
    # @!parse
    #   # OpenFlow 1.0 Echo Request message.
    #   class Request < OpenFlow::Message; end
    class Request < OpenFlow::Message.factory(OpenFlow::Type::ECHO_REQUEST); end

    # @!parse
    #   # OpenFlow 1.0 Echo Reply message.
    #   class Reply < OpenFlow::Message; end
    class Reply < OpenFlow::Message.factory(OpenFlow::Type::ECHO_REPLY); end

    extend Pio::OpenFlow::Parser
  end
end
