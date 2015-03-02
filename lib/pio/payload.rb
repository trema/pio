module Pio
  # Get payload fields.
  module Payload
    def binary_after(field_name)
      all_fields = field_names(true)
      all_fields[(all_fields.index(field_name) + 1)..-1].map do |each|
        __send__(each).to_binary_s
      end.join
    end
  end
end
