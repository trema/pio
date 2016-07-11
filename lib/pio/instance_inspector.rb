module Pio
  # Introduces #inspect method
  module InstanceInspector
    def inspect
      "#<#{self.class.name} " +
        field_names.map do |each|
          next unless __send__("#{each}?")
          "#{each}: #{__send__(each).inspect}"
        end.compact.join(', ') +
        '>'
    end
  end
end
