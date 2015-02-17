require 'pio/open_flow'

module Pio
  # OpenFlow 1.0 Echo Request and Reply message.
  module Echo
    # OpenFlow 1.0 Echo Request message.
    class Request; end
    OpenFlow::Message.factory(Request, OpenFlow::ECHO_REQUEST)

    # OpenFlow 1.0 Echo Reply message.
    class Reply; end
    OpenFlow::Message.factory(Reply, OpenFlow::ECHO_REPLY)
  end
end
