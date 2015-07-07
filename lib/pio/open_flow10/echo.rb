require 'pio/open_flow'
require 'pio/open_flow/echo'

module Pio
  # OpenFlow 1.0 Echo Request and Reply message.
  module Echo
    # OpenFlow 1.0 Echo Request message.
    class Request < OpenFlow::Echo
      version 1
      message_type OpenFlow::ECHO_REQUEST
    end

    # OpenFlow 1.0 Echo Reply message.
    class Reply < OpenFlow::Echo
      version 1
      message_type OpenFlow::ECHO_REPLY
    end
  end
end
