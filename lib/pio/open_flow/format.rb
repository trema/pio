require 'pio/open_flow/open_flow_header'

module Pio
  module OpenFlow
    # OpenFlow message definition macros.
    module Format
      include Forwardable

      # rubocop:disable NestedMethodDefinition
      def self.extended(base)
        base.module_eval do
          def header_length
            8
          end

          def method_missing(method, *args, &block)
            body.__send__ method, *args, &block
          end
        end
      end
      # rubocop:enable NestedMethodDefinition

      # rubocop:disable MethodLength
      def header(options)
        module_eval do
          endian :big

          open_flow_header :header,
                           ofp_version_value: options.fetch(:version),
                           message_type_value: options.fetch(:message_type)

          def_delegators :header, :snapshot
          def_delegators :snapshot, :ofp_version
          def_delegators :snapshot, :message_type
          def_delegators :snapshot, :message_length
          def_delegators :snapshot, :transaction_id
          def_delegator :snapshot, :transaction_id, :xid

          alias_method :to_binary, :to_binary_s
        end
      end
      # rubocop:enable MethodLength
    end
  end
end
