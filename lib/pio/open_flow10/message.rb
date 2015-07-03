require 'English'
require 'bindata'
require 'forwardable'
require 'pio/open_flow/open_flow_header'
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
            extend OpenFlow::Format

            header version: 1, message_type: #{message_type}
            #{klass.const_defined?(:Body) ? 'body' : 'string'} :body
          end

          def self.format
            const_get :Format
          end

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
                             user_options
                           else
                             ''
                           end
            @format = self.class.format.new(header: header_options,
                                            body: body_options)
          end

          def method_missing(method, *args, &block)
            @format.__send__ method, *args, &block
          end
        EOT
      end
      # rubocop:enable MethodLength
    end
  end
end
