require 'pio/dhcp/message'
require 'pio/dhcp/boot_request_options'

module Pio
  class Dhcp
    # DHCP Request Frame Base Class
    class BootRequest < Message
      MESSAGE_TYPE = 1

      # DHCP Options Class.
      class Options < Dhcp::BootRequestOptions; end
    end
  end
end
