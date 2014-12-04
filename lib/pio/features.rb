# encoding: utf-8

require 'pio/features/format'
require 'pio/features/reply'
require 'pio/features/request'
require 'pio/message_type_selector'
require 'pio/open_flow'

module Pio
  # OpenFlow 1.0 Features messages
  class Features
    include Pio::OpenFlow::Type
    extend MessageTypeSelector

    message_type FEATURES_REQUEST => Pio::Features::Request,
                 FEATURES_REPLY => Pio::Features::Reply
  end
end
