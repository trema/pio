require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/core_ext/module/introspection'
require 'pio/open_flow/open_flow_header'
require 'pio/open_flow10'
require 'pio/open_flow13'

module Pio
  # Common OpenFlow modules/classes.
  module OpenFlow
    mattr_reader :version, instance_reader: false

    module_function

    # rubocop:disable ClassVars
    def version=(version)
      return if @@version == version.to_sym
      [Message, Instruction, Action, FlowMatch].each do |each|
        each.descendants.each do |klass|
          define_class klass, Pio.const_get(version)
        end
      end
      @@version = version.to_sym
    rescue NameError
      raise "#{version} is not supported yet."
    end
    # rubocop:enable ClassVars

    def define_class(klass, open_flow_module)
      return if klass.parents.include?(Pio::OpenFlow)
      return unless klass.parents.include?(open_flow_module)
      klass_name = klass.name.split('::')[2].to_sym
      remove_const(klass_name) if const_defined?(klass_name)
      const_set klass_name, open_flow_module.const_get(klass_name)
    end
    private_class_method :define_class

    # The default OpenFlow version is 1.0
    self.version = :OpenFlow10

    def read(binary)
      header = OpenFlowHeaderParser.read(binary)
      self.version = header.version
      parsers.fetch(header.message_type).read(binary)
    end

    def parsers
      [Hello, Error, Echo::Request, Echo::Reply, Features::Request,
       Features::Reply, PacketIn, FlowRemoved, PortStatus, PacketOut,
       FlowMod, Stats::Request, Stats::Reply, Barrier::Request,
       Barrier::Reply].each_with_object({}) do |each, hash|
        hash[each.message_type] = each
      end
    end
    private_class_method :parsers
  end
end
