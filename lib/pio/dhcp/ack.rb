# -*- coding: utf-8 -*-

require 'pio/dhcp/boot_reply'

module Pio
  class Dhcp
    # Dhcp Ack packet generator
    class Ack < BootReply
      TYPE = 5

      def reply_option
        []
      end
    end
  end
end
