require 'pio/open_flow'
require 'pio/open_flow/echo'

# Base module.
module Pio
  remove_const :Echo

  module Echo
    # OpenFlow 1.3 Echo Request message.
    class Request < OpenFlow::Echo
      version 4
      message_type OpenFlow::ECHO_REQUEST
    end

    # OpenFlow 1.3 Echo Reply message.
    class Reply < OpenFlow::Echo
      version 4
      message_type OpenFlow::ECHO_REPLY
    end
  end
end
