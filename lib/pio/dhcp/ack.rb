require 'pio/dhcp/boot_reply'

module Pio
  # Dhcp parser and generator.
  class Dhcp
    # Dhcp Ack packet generator
    class Ack < BootReply
      TYPE = 5
    end
  end
end
