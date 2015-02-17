require 'English'
require 'bindata'
require 'forwardable'
require 'pio/parse_error'

module Pio
  module OpenFlow
    # Defines shortcuts to OpenFlow header fields.
    class Message
      def self.factory(klass, message_type, &block)
        klass.extend Forwardable
        klass.module_eval(&block) if block
        klass.module_eval _format_class(klass, message_type)
        klass.module_eval(&_define_open_flow_accessors)
        klass.module_eval(&_define_self_read)
        klass.module_eval(&_define_initialize)
        klass.module_eval(&_define_to_binary)
      end

      # rubocop:disable MethodLength
      def self._format_class(klass, message_type)
        %(
          class Format < BinData::Record
            endian :big

            open_flow_header :open_flow_header,
            message_type_value: #{message_type}
            virtual assert: -> do
              open_flow_header.message_type == #{message_type}
            end

            #{klass.const_defined?(:Body) ? 'body' : 'string'} :body
          end

          def self.format
            const_get :Format
          end
        )
      end
      # rubocop:enable MethodLength

      def self._define_open_flow_accessors
        proc do
          def_delegators :@format, :open_flow_header
          def_delegators :open_flow_header, :ofp_version
          def_delegators :open_flow_header, :message_type
          def_delegators :open_flow_header, :message_length
          def_delegators :open_flow_header, :transaction_id
          def_delegator :open_flow_header, :transaction_id, :xid

          def_delegators :@format, :body
          def_delegator :@format, :body, :user_data
        end
      end

      def self._define_self_read
        proc do
          def self.read(raw_data)
            allocate.tap do |message|
              message.instance_variable_set(:@format, format.read(raw_data))
            end
          rescue BinData::ValidityError
            message_name = name.split('::')[1..-1].join(' ')
            raise Pio::ParseError, "Invalid #{message_name} message."
          end
        end
      end

      # rubocop:disable MethodLength
      # rubocop:disable AbcSize
      def self._define_initialize
        proc do
          def initialize(user_options = {})
            header_options = OpenFlowHeader::Options.parse(user_options)
            body_options = parse_body_options(user_options)
            @format = self.class.format.new(open_flow_header: header_options,
                                            body: body_options)
          end

          private

          def parse_body_options(options)
            if options.respond_to?(:fetch)
              options.delete :transaction_id
              options.delete :xid
              dpid = options[:dpid]
              options[:datapath_id] = dpid if dpid
              if options.keys.size > 1
                options
              else
                options[:user_data] || ''
              end
            else
              ''
            end
          end
        end
      end
      # rubocop:enable MethodLength
      # rubocop:enable AbcSize

      def self._define_to_binary
        proc do
          def_delegator :@format, :to_binary_s, :to_binary
        end
      end
    end
  end
end
