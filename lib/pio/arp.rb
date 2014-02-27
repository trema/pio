# -*- coding: utf-8 -*-
require 'English'
require 'rubygems'
require 'bindata'

require 'pio/arp/request'
require 'pio/arp/reply'
require 'pio/util'

module Pio
  # ARP parser and generator.
  class Arp
    MESSAGE_TYPE = {
      Request::OPERATION => Request,
      Reply::OPERATION => Reply
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
