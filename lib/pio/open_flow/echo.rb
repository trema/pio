require 'pio/open_flow'

module Pio
  module OpenFlow
    # Base class of Echo Request and Reply.
    class Echo < OpenFlow::Message
      # rubocop:disable MethodLength
      def self.inherited(child)
        child.module_eval <<-EOS
          class Format < BinData::Record
            extend OpenFlow::Format

            header version: :of_version,
                   message_type: :of_message_type
            string :body, read_length: -> { message_length - header_length }

            def user_data
              body
            end
          end
        EOS
      end
      # rubocop:enable MethodLength

      def self.version(version)
        const_get(:Format).tap do |klass|
          klass.__send__(:define_method, :of_version) { version }
          klass.class_eval { private :of_version }
        end
      end

      def self.message_type(message_type)
        const_get(:Format).tap do |klass|
          klass.__send__(:define_method, :of_message_type) { message_type }
          klass.class_eval { private :of_message_type }
        end
      end

      def initialize(user_options = {})
        unknown_options =
          user_options.keys - [:transaction_id, :xid, :body, :user_data]
        unless unknown_options.empty?
          fail "Unknown keyword: #{unknown_options.first}"
        end
        header_options = OpenFlowHeader::Options.parse(user_options)
        body_options = user_options[:body] || user_options[:user_data] || ''
        @format = self.class.const_get(:Format).new(header: header_options,
                                                    body: body_options)
      end
    end
  end
end
