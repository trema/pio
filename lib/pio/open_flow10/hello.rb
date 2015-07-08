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

    user_option :transaction_id
    user_option :xid
    user_option :body
    user_option :user_data

    def initialize(user_options = {})
      validate_user_options user_options
      header_options = OpenFlowHeader::Options.parse(user_options)
      body_options = user_options[:body] || user_options[:user_data] || ''
      @format = Format.new(header: header_options, body: body_options)
    end
  end
end
