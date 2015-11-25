require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/core_ext/module/introspection'
require 'pio/open_flow/error'
require 'pio/open_flow/open_flow_header'
require 'pio/open_flow10'
require 'pio/open_flow13'

module Pio
  # Common OpenFlow modules/classes.
  module OpenFlow
    mattr_reader :version

    module_function

    def version=(version)
      [Message, Action, Match].each do |each|
        each.descendants.each do |klass|
          switch_class klass, version
        end
      end
      @@version = version.to_sym # rubocop:disable ClassVars
    end

    def switch_class(klass, version)
      open_flow_module = Pio.const_get(version)
      return if klass.parents.include?(Pio::OpenFlow)
      return unless klass.parents.include?(open_flow_module)
      klass_name = klass.name.split('::')[2].to_sym
      Pio.__send__ :remove_const, klass_name if Pio.const_defined?(klass_name)
      Pio.const_set(klass_name, open_flow_module.const_get(klass_name))
    rescue NameError
      raise "#{version} is not supported yet."
    end
    private_class_method :switch_class

    # The default OpenFlow version is 1.0
    self.version = 'OpenFlow10'

    # rubocop:disable MethodLength
    def read(binary)
      {
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
      }.fetch(OpenFlowHeaderParser.read(binary).message_type).read(binary)
    end
    # rubocop:enable MethodLength
  end
end
