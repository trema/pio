require 'pio/open_flow/error_message'
require 'pio/open_flow/hello_failed_code'
require 'pio/open_flow/message'
require 'pio/open_flow10/error/error_type10'

module Pio
  module OpenFlow10
    module Error
      # Hello failed error.
      class HelloFailed < OpenFlow::Message
        open_flow_header version: 1,
                         type: OpenFlow::ErrorMessage.type,
                         length: -> { header_length + 4 + description.length }

        error_type10 :error_type, value: -> { :hello_failed }
        hello_failed_code :error_code
        string :description, read_length: -> { length - header_length - 4 }
      end
    end
  end
end
