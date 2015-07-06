require 'pio/open_flow'

module Pio
  # OpenFlow 1.0 Echo Request and Reply message.
  module Echo
    # OpenFlow 1.0 Echo Request message.
    class Request < OpenFlow::Message
      # OpenFlow 1.0 Hello message
      class Format < BinData::Record
        extend OpenFlow::Format

        header version: 1, message_type: OpenFlow::ECHO_REQUEST
        string :body

        def user_data
          body
        end
      end

      def initialize(user_options = {})
        header_options = OpenFlowHeader::Options.parse(user_options)
        body_options = user_options[:body] || user_options[:user_data] || ''
        @format = Format.new(header: header_options, body: body_options)
      end
    end

    # OpenFlow 1.0 Echo Reply message.
    class Reply < OpenFlow::Message
      # OpenFlow 1.0 Hello message
      class Format < BinData::Record
        extend OpenFlow::Format

        header version: 1, message_type: OpenFlow::ECHO_REPLY
        string :body

        def user_data
          body
        end
      end

      def initialize(user_options = {})
        header_options = OpenFlowHeader::Options.parse(user_options)
        body_options = user_options[:body] || user_options[:user_data] || ''
        @format = Format.new(header: header_options, body: body_options)
      end
    end
  end
end
