require 'pio/open_flow10/match'
require 'pio/open_flow10/stats_type'
require 'pio/open_flow/format'
require 'pio/open_flow/message'

# Base module.
module Pio
  # OpenFlow 1.0 messages
  module OpenFlow10
    # OpenFlow 1.0 FlowStats messages
    module FlowStats
      # OpenFlow 1.0 Flow Stats Request message
      class Request < OpenFlow::Message
        # Body for Stats Request of type :flow
        class FlowStatsRequestBody < BinData::Record
          endian :big

          match_open_flow10 :match
          uint8 :table_id, initial_value: 0xff
          string :padding, length: 1
          hide :padding
          port16 :out_port, initial_value: -> { :none }
        end

        # Message body of Flow Stats Request.
        class Body < BinData::Record
          endian :big

          stats_type :stats_type, value: -> { :flow }
          uint16 :flags
          choice :stats_request_body, selection: -> { stats_type.to_s } do
            flow_stats_request_body 'flow'
            string :default
          end

          def length
            48
          end

          def method_missing(method, *args, &block)
            stats_request_body.__send__(method, *args, &block)
          end
        end

        # OpenFlow 1.0 Flow Stats Request message format.
        class Format < BinData::Record
          extend OpenFlow::Format

          header version: 1, message_type: 16
          body :body
        end

        body_option :match

        def initialize(user_options = {})
          validate_user_options user_options
          header_options = parse_header_options(user_options)
          @format = Format.new(header: header_options,
                               body: { stats_request_body: user_options })
        end
      end
    end
  end
end
