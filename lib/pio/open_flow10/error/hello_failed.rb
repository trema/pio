require 'pio/open_flow/hello_failed_code'
require 'pio/open_flow/message'
require 'pio/open_flow10/error/error_type10'

module Pio
  module OpenFlow10
    module Error
      # Hello failed error.
      class HelloFailed < OpenFlow::Message
        open_flow_header version: 1,
                         message_type: 1,
                         message_length: -> { 12 + description.length }
        error_type10 :error_type
        hello_failed_code :error_code
        rest :description
      end
    end
  end
end
