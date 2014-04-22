# encoding: utf-8

require 'bindata'
require 'pio/type/open_flow'

module Pio
  class Echo
    # OpenFlow 1.0 Echo message format.
    class Format < BinData::Record
      extend Type::OpenFlow

      endian :big

      openflow_header
      string :body
    end
  end
end
