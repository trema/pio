require 'pio/open_flow/message'

module Pio
  module OpenFlow10
    # Hello message
    class Hello < OpenFlow::Message
      open_flow_header version: 1, type: 0
    end
  end
end
