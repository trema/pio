# -*- coding: utf-8 -*-
require 'rubygems'
require 'bindata'

require 'pio/icmp/frame'
require 'pio/icmp/request'
require 'pio/icmp/reply'
require 'pio/util'

module Pio
  # Icmp parser and generator.
  class Icmp
    MESSAGE_TYPE = {
      Request::TYPE => Request,
      Reply::TYPE => Reply
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
