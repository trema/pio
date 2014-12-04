# encoding: utf-8

require 'bindata'
require 'pio/open_flow'

module Pio
  class Features
    # OpenFlow 1.0 Features message format.
    class Format < BinData::Record
      endian :big

      open_flow_header :open_flow_header
      string :body, read_length: -> { open_flow_header.message_length - 8 }

      def message_type
        open_flow_header.message_type
      end
    end
  end
end
