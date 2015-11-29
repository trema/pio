require 'pio/open_flow/message'

module Pio
  module OpenFlow10
    # Features Request and Reply message.
    class Features
      # Features Request message.
      class Request < OpenFlow::Message
        open_flow_header version: 1, type: 5
      end
    end
  end
end
