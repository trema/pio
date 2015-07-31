require 'pio/open_flow/datapath_id'
require 'pio/open_flow/flags'
require 'pio/open_flow/format'
require 'pio/open_flow/message'
require 'pio/open_flow/open_flow_header'
require 'pio/open_flow/phy_port'
require 'pio/open_flow/port_number'
require 'pio/open_flow10'
require 'pio/open_flow13'

module Pio
  # Common OpenFlow modules/classes.
  module OpenFlow
    def self.version
      @version || 'OpenFlow10'
    end

    def self.switch_version(version)
      [:Barrier, :Echo, :Features, :FlowMod, :Hello, :Match,
       :PacketIn, :PacketOut, :SendOutPort].each do |each|
        set_message_class_name each, version
        @version = version.to_s
      end
    end

    def self.set_message_class_name(klass_name, version)
      open_flow_module = Pio.const_get(version)
      return unless open_flow_module.const_defined?(klass_name)
      Pio.__send__ :remove_const, klass_name if Pio.const_defined?(klass_name)
      Pio.const_set(klass_name, open_flow_module.const_get(klass_name))
    rescue NameError
      raise "#{version} is not supported yet."
    end
    private_class_method :set_message_class_name
  end
end
