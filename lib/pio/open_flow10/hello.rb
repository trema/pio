require 'pio/open_flow'

# Base module.
module Pio
  # OpenFlow 1.0 Hello message
  class Hello < OpenFlow::Message
    # OpenFlow 1.0 Hello message format
    class Format < BinData::Record
      extend OpenFlow::Format

      header version: 1, message_type: OpenFlow::HELLO
      string :body

      def user_data
        body
      end
    end

    body_option :body
    body_option :user_data
  end
end
