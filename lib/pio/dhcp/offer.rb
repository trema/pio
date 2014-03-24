# -*- coding: utf-8 -*-
require 'pio/dhcp/boot_reply'

module Pio
  class Dhcp
    # Dhcp Offer packet generator
    class Offer < BootReply
      TYPE = 2

      def reply_option
        []
      end
    end
  end
end
