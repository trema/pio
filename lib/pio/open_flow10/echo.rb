require 'pio/open_flow/echo'

module Pio
  # This module smells of :reek:UncommunicativeModuleName
  module OpenFlow10
    # OpenFlow 1.0 Echo Request and Reply message.
    module Echo
      # OpenFlow 1.0 Echo Request message.
      class Request < OpenFlow::Echo
        version 1
        message_type 2
      end

      # OpenFlow 1.0 Echo Reply message.
      class Reply < OpenFlow::Echo
        version 1
        message_type 3
      end
    end
  end
end
