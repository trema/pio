require 'active_support/core_ext/array/access'
require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/core_ext/module/introspection'
require 'active_support/core_ext/module/qualified_const.rb'
require 'pio/open_flow/header'
require 'pio/open_flow/parser'

module Pio
  # Common OpenFlow modules/classes.
  module OpenFlow
    mattr_reader :version, instance_reader: false

    def self.version=(version)
      return if OpenFlow.version == version.to_sym
      find_all_class_by_version(version).each do |each|
        alias_open_flow_class each
      end
      @@version = version.to_sym # rubocop:disable ClassVars
    rescue NameError
      raise "#{version} is not supported yet."
    end

    def self.read(binary)
      header = OpenFlow::Header.read(binary)
      self.version = header.version
      Parser.find_by_type!(header.type).read(binary)
    end

    def self.find_all_class_by_version(version)
      all_class = [Message, Instruction, Action, FlowMatch].
                  inject([]) do |result, each|
        result + each.descendants
      end
      all_class.select do |each|
        each.parents.include?(Class.const_get("Pio::#{version}"))
      end
    end
    private_class_method :find_all_class_by_version

    # Pio::OpenFlow10::Hello -> Pio::Hello
    def self.alias_open_flow_class(klass)
      version = klass.name.split('::').second
      class_name = klass.name.split('::').third
      if Pio.const_defined?(class_name)
        Pio.module_eval { remove_const class_name }
      end
      Object.qualified_const_set("Pio::#{class_name}",
                                 "Pio::#{version}::#{class_name}".constantize)
    end
    private_class_method :alias_open_flow_class
  end
end

# The default OpenFlow version is 1.0
Pio::OpenFlow.version = :OpenFlow10
