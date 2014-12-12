require 'pio/dhcp/boot_request'

module Pio
  class Dhcp
    # Dhcp Request packet generator
    class Request < BootRequest
      TYPE = 3
    end
  end
end
