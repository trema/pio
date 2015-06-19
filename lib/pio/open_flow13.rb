module Pio
  # OpenFlow specific types.
  module OpenFlow
    remove_const :VERSION
    VERSION = 4
  end
end

require 'pio/open_flow13/apply'
require 'pio/open_flow13/goto_table'
require 'pio/open_flow13/write_metadata'
require 'pio/open_flow13/meter'
require 'pio/open_flow13/echo'
require 'pio/open_flow13/features_reply'
require 'pio/open_flow13/features_request'
require 'pio/open_flow13/flow_mod'
require 'pio/open_flow13/hello'
require 'pio/open_flow13/match'
require 'pio/open_flow13/send_out_port'

# Base module.
module Pio
  remove_const :Match
  Match = OpenFlow13::Match
end
