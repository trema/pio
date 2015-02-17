require 'pio/open_flow'

# Base module.
module Pio
  # OpenFlow 1.0 Hello message
  class Hello; end
  OpenFlow::Message.factory(Hello, OpenFlow::HELLO)
end
