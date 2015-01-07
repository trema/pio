require 'pio/open_flow'

module Pio
  # OpenFlow 1.0 flow setup and teardown message.
  class FlowMod < OpenFlow::Message.factory(OpenFlow::Type::FLOW_MOD)
  end
end
