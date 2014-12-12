require 'pio/dhcp/message'
require 'pio/dhcp/boot_reply_options'

module Pio
  class Dhcp
    # DHCP Reply Frame Base Class
    class BootReply < Message
      MESSAGE_TYPE = 2

      # DHCP Options Class.
      class Options < Dhcp::BootReplyOptions; end
    end
  end
end
