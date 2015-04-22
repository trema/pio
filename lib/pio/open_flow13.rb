module Pio
  # OpenFlow specific types.
  module OpenFlow
    remove_const :VERSION
    VERSION = 4
  end
end

require 'pio/open_flow13/echo'
require 'pio/open_flow13/features_reply'
require 'pio/open_flow13/features_request'
require 'pio/open_flow13/hello'
