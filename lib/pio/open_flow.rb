module Pio
  # OpenFlow specific types.
  module OpenFlow
    def self.set_class_name(klass_name, open_flow_module)
      return unless Pio.const_get(open_flow_module).const_defined?(klass_name)
      Pio.__send__ :remove_const, klass_name if Pio.const_defined?(klass_name)
      Pio.const_set(klass_name,
                    Pio.const_get(open_flow_module).const_get(klass_name))
      nil
    end

    def self.switch_version(open_flow_module)
      set_class_name :Barrier, open_flow_module
      set_class_name :Echo, open_flow_module
      set_class_name :Features, open_flow_module
      set_class_name :FlowMod, open_flow_module
      set_class_name :Hello, open_flow_module
      set_class_name :Match, open_flow_module
      set_class_name :PacketIn, open_flow_module
      set_class_name :PacketOut, open_flow_module
      set_class_name :SendOutPort, open_flow_module
    end
  end
end

require 'pio/open_flow/datapath_id'
require 'pio/open_flow/flags'
require 'pio/open_flow/format'
require 'pio/open_flow/message'
require 'pio/open_flow/open_flow_header'
require 'pio/open_flow/phy_port'
require 'pio/open_flow/port_number'
