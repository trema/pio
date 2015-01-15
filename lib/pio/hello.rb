require 'pio/open_flow'

module Pio
  # @!parse
  #   # OpenFlow 1.0 Hello message
  #   class Hello < OpenFlow::Message; end
  class Hello < OpenFlow::Message.factory(Pio::OpenFlow::Type::HELLO); end
end
