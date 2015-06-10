require 'English'
require 'bindata'
require 'forwardable'
require 'pio/parse_error'

module Pio
  module OpenFlow
    # Defines shortcuts to OpenFlow header fields.
    # rubocop:disable MethodLength
    class Message
      def self.factory(klass, message_type, &block)
        klass.extend Forwardable
        klass.module_eval(&block) if block
        klass.module_eval <<-EOT, __FILE__, __LINE__
          class Format < BinData::Record
            endian :big

            open_flow_header :open_flow_header,
                             ofp_version_value: 1,
                             message_type_value: #{message_type}
            virtual assert: -> do
              open_flow_header.message_type == #{message_type}
            end

            #{klass.const_defined?(:Body) ? 'body' : 'string'} :body
          end

          def self.format
            const_get :Format
          end

          def_delegators :@format, :snapshot
          def_delegators :snapshot, :open_flow_header
          def_delegators :open_flow_header, :ofp_version
          def_delegators :open_flow_header, :message_type
          def_delegators :open_flow_header, :message_length
          def_delegators :open_flow_header, :transaction_id
          def_delegator :open_flow_header, :transaction_id, :xid

          def_delegators :snapshot, :body
          def_delegator :snapshot, :body, :user_data

          def self.read(raw_data)
            allocate.tap do |message|
              message.instance_variable_set(:@format, format.read(raw_data))
            end
          rescue BinData::ValidityError
            message_name = name.split('::')[1..-1].join(' ')
            raise Pio::ParseError, "Invalid \#{message_name} message."
          end

          def initialize(user_options = {})
            header_options = OpenFlowHeader::Options.parse(user_options)
            body_options = if user_options.respond_to?(:fetch)
                             user_options.delete :transaction_id
                             user_options.delete :xid
                             dpid = user_options[:dpid]
                             user_options[:datapath_id] = dpid if dpid
                             if user_options.keys.size > 1
                               user_options
                             else
                               user_options[:user_data] || ''
                             end
                           else
                             ''
                           end
            @format = self.class.format.new(open_flow_header: header_options,
                                            body: body_options)
          end

          def_delegator :@format, :to_binary_s, :to_binary
        EOT
      end
      # rubocop:enable MethodLength
    end
  end
end
