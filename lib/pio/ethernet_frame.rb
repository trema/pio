# frozen_string_literal: true

require 'bindata'
require 'pio/ethernet_header'
require 'pio/class_inspector'
require 'pio/instance_inspector'
require 'pio/ruby_dumper'

module Pio
  # Ethernet frame parser
  class EthernetFrame < BinData::Record
    extend ClassInspector
    include Ethernet
    include InstanceInspector
    include RubyDumper

    endian :big

    ethernet_header
    rest :rest
  end
end
