require 'pio/open_flow'

# Base module.
module Pio
  # OpenFlow 1.0 Hello message
  class Hello
    # OpenFlow 1.0 Hello message
    class Format < BinData::Record
      endian :big

      open_flow_header :open_flow_header,
                       ofp_version_value: 1,
                       message_type_value: OpenFlow::HELLO
      virtual assert: -> { open_flow_header.message_type == OpenFlow::HELLO }

      string :body
    end

    extend Forwardable

    def_delegators :@format, :snapshot
    def_delegators :snapshot, :open_flow_header
    def_delegators :open_flow_header, :ofp_version
    def_delegators :open_flow_header, :message_type
    def_delegators :open_flow_header, :message_length
    def_delegators :open_flow_header, :transaction_id
    def_delegator :open_flow_header, :transaction_id, :xid

    def_delegators :snapshot, :body
    def_delegator :snapshot, :body, :user_data
    def_delegator :@format, :to_binary_s, :to_binary

    def self.read(raw_data)
      allocate.tap do |message|
        message.instance_variable_set(:@format, Format.read(raw_data))
      end
    rescue BinData::ValidityError
      raise Pio::ParseError, 'Invalid Hello message.'
    end

    def initialize(user_options = {})
      header_options = OpenFlowHeader::Options.parse(user_options)
      body_options = user_options[:body] || user_options[:user_data] || ''
      @format = Format.new(open_flow_header: header_options,
                           body: body_options)
    end
  end
end
