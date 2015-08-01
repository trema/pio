require 'pio/open_flow/echo'

# Base module.
module Pio
  module OpenFlow13
    module Echo
      # OpenFlow 1.3 Echo Request message.
      class Request < OpenFlow::Echo
        version 4
        message_type 2
      end

      # OpenFlow 1.3 Echo Reply message.
      class Reply < OpenFlow::Echo
        version 4
        message_type 3
      end
    end
  end
end
