require 'pio/open_flow'

# Base module.
module Pio
  # OpenFlow 1.3 Features Request and Reply message.
  class Features
    remove_const :Request

    # OpenFlow 1.3 Features Request message.
    class Request < OpenFlow::Message
      # OpenFlow 1.3 Features Request message format.
      class Format < BinData::Record
        extend OpenFlow::Format

        header version: 4, message_type: 5
        string :body, value: ''
      end

      def initialize(user_attrs = {})
        unknown_attrs = user_attrs.keys - [:transaction_id, :xid]
        unless unknown_attrs.empty?
          fail "Unknown option: #{unknown_attrs.first}"
        end
        header_options = OpenFlowHeader::Options.parse(user_attrs)
        @format = Format.new(header: header_options)
      end
    end
  end
end
