require 'pio/open_flow/datapath_id'
require 'pio/open_flow/error'
require 'pio/open_flow/flags'
require 'pio/open_flow/message'
require 'pio/open_flow/open_flow_header'
require 'pio/open_flow10'
require 'pio/open_flow13'

module Pio
  # Common OpenFlow modules/classes.
  module OpenFlow
    def self.version
      fail unless @version
      @version
    end

    def self.switch_version(version)
      [:Barrier, :Echo, :Features, :FlowMod, :Hello, :Match,
       :PacketIn, :FlowRemoved, :PacketOut, :SendOutPort,
       :SetSourceMacAddress, :SetDestinationMacAddress, :PortStatus, :Stats,
       :FlowStats, :DescriptionStats, :AggregateStats, :TableStats, :PortStats,
       :QueueStats, :Error, :SetArpOperation, :SetArpSenderProtocolAddress,
       :SetArpSenderHardwareAddress, :NiciraRegMove, :SetMetadata,
       :NiciraRegLoad, :NiciraSendOutPort].each do |each|
        set_message_class_name each, version
        @version = version.to_s
      end
    end

    # rubocop:disable MethodLength
    def self.read(binary)
      parser = {
        0 => Pio::Hello,
        1 => Pio::OpenFlow::Error,
        2 => Pio::Echo::Request,
        3 => Pio::Echo::Reply,
        5 => Pio::Features::Request,
        6 => Pio::Features::Reply,
        10 => Pio::PacketIn,
        11 => Pio::FlowRemoved,
        12 => Pio::PortStatus,
        13 => Pio::PacketOut,
        14 => Pio::FlowMod,
        16 => Pio::Stats::Request,
        17 => Pio::Stats::Reply,
        18 => Pio::Barrier::Request,
        19 => Pio::Barrier::Reply
      }
      header = OpenFlowHeaderParser.read(binary)
      parser.fetch(header.message_type).read(binary)
    end
    # rubocop:enable MethodLength

    def self.set_message_class_name(klass_name, version)
      open_flow_module = Pio.const_get(version)
      return unless open_flow_module.const_defined?(klass_name)
      Pio.__send__ :remove_const, klass_name if Pio.const_defined?(klass_name)
      Pio.const_set(klass_name, open_flow_module.const_get(klass_name))
    rescue NameError
      raise "#{version} is not supported yet."
    end
    private_class_method :set_message_class_name

    # The default OpenFlow version is 1.0
    switch_version 'OpenFlow10'
  end
end
