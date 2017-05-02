# frozen_string_literal: true

require 'pio/dhcp/boot_reply'

module Pio
  class Dhcp
    # Dhcp Offer packet generator
    class Offer < BootReply
      TYPE = 2
    end
  end
end
