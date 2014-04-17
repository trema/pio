# encoding: utf-8

require 'bindata'
require 'pio/type/open_flow'

module Pio
  class Features
    # OpenFlow 1.0 Features message format.
    class Format < BinData::Record
      extend Type::OpenFlow

      openflow_header
      string :body
    end
  end
end
