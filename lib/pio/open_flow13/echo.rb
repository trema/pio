require 'pio/open_flow'

# Base module.
module Pio
  remove_const :Echo

  module Echo
    # Base class of Echo Request and Reply.
    class Message < OpenFlow::Message
      def initialize(user_attrs = {})
        unknown_attrs = user_attrs.keys - [:transaction_id, :xid, :body]
        unless unknown_attrs.empty?
          fail "Unknown keyword: #{unknown_attrs.first}"
        end
        header_options = OpenFlowHeader::Options.parse(user_attrs)
        @format =
          self.class.const_get(:Format).new(header: header_options,
                                            body: user_attrs[:body])
      end
    end

    # OpenFlow 1.3 Echo Request message.
    class Request < Message
      # OpenFlow 1.3 Echo Request message format.
      class Format < BinData::Record
        extend OpenFlow::Format

        header version: 4, message_type: 2
        string :body, read_length: -> { message_length - 8 }
      end
    end

    # OpenFlow 1.3 Echo Reply message.
    class Reply < Message
      # OpenFlow 1.3 Echo Request message format.
      class Format < BinData::Record
        extend OpenFlow::Format

        header version: 4, message_type: 3
        string :body, read_length: -> { message_length - 8 }
      end
    end
  end
end
