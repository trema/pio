require 'active_support/core_ext/string/inflections'

module Pio
  # Introduces Class.inspect method
  module ClassInspector
    # rubocop:disable LineLength
    def inspect
      field_and_type = fields.each_with_object([]) do |each, result|
        next if each.name == :padding
        result << [each.name,
                   each.prototype.instance_variable_get(:@obj_class).name.demodulize.sub(/be$/, '').underscore]
      end
      signature = field_and_type.map { |field, type| "#{field}: #{type}" }.join(', ')
      "#{self}(#{signature})"
    end
    # rubocop:enable LineLength
  end
end
