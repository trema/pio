# encoding: utf-8

require 'bindata'
require 'pio/type/open_flow'

module Pio
  class Features
    # OpenFlow 1.0 Features message format.
    class Format < BinData::Record
      extend Type::OpenFlow

      endian :big

      openflow_header
      string :body, read_length: -> { message_length - 8 }
    end
  end
end
