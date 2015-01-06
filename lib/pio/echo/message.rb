require 'pio/open_flow'

module Pio
  class Echo
    # Base class of Echo request and reply.
    class Message < Pio::OpenFlow::Message
      # Message body of Echo
      class Body < BinData::Record
        endian :big

        string :body

        def length
          body.length
        end

        def empty?
          length == 0
        end

        def ==(other)
          body == other
        end
      end

      # rubocop:disable MethodLength
      # rubocop:disable AbcSize
      # This method smells of :reek:FeatureEnvy
      def initialize(user_options = {})
        if user_options.respond_to?(:to_i)
          options = { open_flow_header: { transaction_id: user_options.to_i } }
        elsif user_options.respond_to?(:fetch)
          header_options = { transaction_id: user_options[:transaction_id] ||
                                             user_options[:xid] || 0 }
          options = { open_flow_header: header_options,
                      body: { body: user_options[:user_data] } }
        else
          fail TypeError
        end
        if options[:open_flow_header][:transaction_id] >= 2**32
          fail ArgumentError, 'Transaction ID >= 2**32'
        end
        @format = self.class.const_get(:Format).new(options)
      end
      # rubocop:enable AbcSize
      # rubocop:enable MethodLength
    end
  end
end
