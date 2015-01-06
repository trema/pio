require 'pio/features/reply'
require 'pio/features/request'
require 'pio/open_flow'
require 'pio/open_flow/parser'

module Pio
  # OpenFlow 1.0 Features Request and Reply message parser.
  class Features
    KLASS = { Pio::OpenFlow::Type::FEATURES_REQUEST => Pio::Features::Request,
              Pio::OpenFlow::Type::FEATURES_REPLY => Pio::Features::Reply }

    extend Pio::OpenFlow::Parser
  end
end
