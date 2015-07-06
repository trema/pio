require 'pio/open_flow'

# Base module.
module Pio
  # OpenFlow 1.0 Hello message
  class Hello < OpenFlow::Message
    # OpenFlow 1.0 Hello message
    class Format < BinData::Record
      extend OpenFlow::Format

      header version: 1, message_type: OpenFlow::HELLO
      string :body
    end

    def initialize(user_options = {})
      header_options = OpenFlowHeader::Options.parse(user_options)
      body_options = user_options[:body] || user_options[:user_data] || ''
      @format = Format.new(header: header_options, body: body_options)
    end
  end
end
