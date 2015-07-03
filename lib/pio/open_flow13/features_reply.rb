require 'forwardable'
require 'pio/open_flow'

# Base module.
module Pio
  # OpenFlow 1.3 Features Request and Reply message.
  class Features
    remove_const :Reply if const_defined?(:Reply)

    # OpenFlow 1.3 Features Reply message.
    class Reply
      # OpenFlow 1.3 Features Reply message body.
      class Body < BinData::Record
        extend OpenFlow::Flags

        flags_32bit(:capabilities,
                    [:flow_stats,
                     :table_stats,
                     :port_stats,
                     :group_stats,
                     :NOT_USED,
                     :ip_reasm,
                     :queue_stats,
                     :NOT_USED,
                     :port_blocked])

        endian :big

        datapath_id :datapath_id
        uint32 :n_buffers
        uint8 :n_tables
        uint8 :auxiliary_id
        uint16 :padding
        hide :padding
        capabilities :capabilities
        uint32 :reserved

        def length
          24
        end
      end

      # OpenFlow 1.3 Features Reply message format.
      class Format < BinData::Record
        extend OpenFlow::Format

        header version: 4, message_type: 6
        body :body

        def dpid
          datapath_id
        end
      end

      def self.read(raw_data)
        allocate.tap do |message|
          message.instance_variable_set(:@format, Format.read(raw_data))
        end
      rescue BinData::ValidityError
        raise Pio::ParseError, 'Invalid Features Reply 1.3 message.'
      end

      def initialize(user_attrs = {})
        header_options = OpenFlowHeader::Options.parse(user_attrs)
        body_options = user_attrs.dup
        body_options[:datapath_id] =
          body_options[:dpid] || body_options[:datapath_id]
        @format = Format.new(header: header_options, body: body_options)
      end

      def method_missing(method, *args, &block)
        @format.__send__ method, *args, &block
      end
    end
  end
end
