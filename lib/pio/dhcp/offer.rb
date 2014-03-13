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

### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
