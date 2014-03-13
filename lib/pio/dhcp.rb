# -*- coding: utf-8 -*-

require 'rubygems'
require 'bindata'

require 'pio/dhcp/discover'
require 'pio/dhcp/offer'
require 'pio/dhcp/request'
require 'pio/dhcp/ack'

require 'pio/util'

module Pio
  # Dhcp parser and generator.
  class Dhcp
    MESSAGE_TYPE = {
      Discover::TYPE => Discover,
      Offer::TYPE => Offer,
      Request::TYPE => Request,
      Ack::TYPE => Ack
    }
    class << self
      include Util
    end
  end
end

### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
