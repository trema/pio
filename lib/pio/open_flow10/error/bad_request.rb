# frozen_string_literal: true

require 'pio/open_flow/error_message'
require 'pio/open_flow/message'
require 'pio/open_flow10/error/bad_request/bad_request_code'
require 'pio/open_flow10/error/error_type10'

module Pio
  module OpenFlow10
    module Error
      # Bad request error.
      class BadRequest < OpenFlow::Message
        open_flow_header version: 1,
                         type: OpenFlow::ErrorMessage.type,
                         length: -> { header_length + 4 + raw_data.length }
        error_type10 :error_type, value: -> { :bad_request }
        bad_request_code :error_code
        string :raw_data, read_length: -> { length - header_length - 4 }
      end
    end
  end
end
