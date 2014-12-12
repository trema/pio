require 'pio/dhcp/boot_request'

module Pio
  class Dhcp
    # Dhcp Discover packet generator
    class Discover < BootRequest
      TYPE = 1
    end
  end
end
