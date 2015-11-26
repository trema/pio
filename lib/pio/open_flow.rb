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

    # rubocop:disable ClassVars
    def version=(version)
      return if @@version == version.to_sym
      [Message, Instruction, Action, FlowMatch].each do |each|
        each.descendants.each do |klass|
          switch_class klass, version
        end
      end
      @@version = version.to_sym
    end
    # rubocop:enable ClassVars

    def switch_class(klass, version)
      open_flow_module = Pio.const_get(version)
      return if klass.parents.include?(Pio::OpenFlow)
      return unless klass.parents.include?(open_flow_module)
      klass_name = klass.name.split('::')[2].to_sym
      remove_const(klass_name) if const_defined?(klass_name)
      const_set klass_name, open_flow_module.const_get(klass_name)
    rescue NameError
      raise "#{version} is not supported yet."
    end
    private_class_method :switch_class

    # The default OpenFlow version is 1.0
    self.version = :OpenFlow10

    # rubocop:disable MethodLength
    def read(binary)
      header = OpenFlowHeaderParser.read(binary)
      self.version = header.version
      {
        0 => Hello,
        1 => Error,
        2 => Echo::Request,
        3 => Echo::Reply,
        5 => Features::Request,
        6 => Features::Reply,
        10 => PacketIn,
        11 => FlowRemoved,
        12 => PortStatus,
        13 => PacketOut,
        14 => FlowMod,
        16 => Stats::Request,
        17 => Stats::Reply,
        18 => Barrier::Request,
        19 => Barrier::Reply
      }.fetch(header.message_type).read(binary)
    end
    # rubocop:enable MethodLength
  end
end
