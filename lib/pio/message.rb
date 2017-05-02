# frozen_string_literal: true

require 'active_support/core_ext/class/attribute'
require 'pio/ruby_dumper'

module Pio
  # Base message class
  class Message
    include RubyDumper

    class_attribute :options

    def self.option(name, value: nil, default: nil)
      self.options ||= {}
      if value && !value.is_a?(Symbol)
        class_eval { class_attribute name }
        class_eval { __send__("#{name}=", value) }
      end
      self.options.merge! name => { value: value, default: default }
    end

    private

    # rubocop:disable MethodLength
    # rubocop:disable AbcSize
    # rubocop:disable PerceivedComplexity
    # rubocop:disable CyclomaticComplexity
    def parse_options(user_options)
      options = {}
      self.class.options.each_pair do |key, attrs|
        if !attrs[:value] && !attrs[:default]
          begin
            options[key] = user_options.fetch(key)
          rescue
            raise "#{key} option is a mandatory"
          end
        elsif attrs[:value] && attrs[:value].is_a?(Symbol)
          options[key] = user_options.fetch(attrs[:value])
        elsif attrs[:value]
          options[key] = user_options[key] || attrs[:value]
        else
          options[key] = user_options[key] || attrs[:default]
        end
      end
      options
    end
    # rubocop:enable MethodLength
    # rubocop:enable AbcSize
    # rubocop:enable PerceivedComplexity
    # rubocop:enable CyclomaticComplexity
  end
end
