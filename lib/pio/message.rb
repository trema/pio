require 'active_support/core_ext/class/attribute'
require 'pio/ruby_dumper'

module Pio
  # Base message class
  class Message
    include RubyDumper

    class_attribute :options

    def self.options(options)
      options.each_pair do |key, value|
        next if value.is_a?(Symbol)
        class_eval { class_attribute key }
        class_eval { __send__("#{key}=", value) }
      end
      self.options = options
    end

    private

    # rubocop:disable MethodLength
    def parse_options(user_options)
      options = {}
      self.class.options.each_pair do |key, value|
        if value.is_a?(Symbol)
          begin
            options[key] = user_options.fetch(value)
          rescue
            raise "#{key} option is a mandatory"
          end
        else
          options[key] = user_options[key] || value
        end
      end
      options
    end
    # rubocop:enable MethodLength
  end
end
