module Pio
  module OpenFlow10
    module Error
      # enum ofp_error_type
      class ErrorType10 < BinData::Primitive
        ERROR_TYPES = {
          hello_failed: 0,
          bad_request: 1,
          bad_action: 2,
          flow_mod_failed: 3,
          port_mod_failed: 4,
          queue_operation_failed: 5
        }

        endian :big
        uint16 :error_type

        def get
          ERROR_TYPES.invert.fetch(error_type)
        end

        def set(value)
          self.error_type = ERROR_TYPES.fetch(value)
        end
      end
    end
  end
end
