# encoding: utf-8

module Pio
  class Echo
    # Base class of Echo request and reply.
    class Message < Pio::OpenFlow::Message
      # @reek This method smells of :reek:FeatureEnvy
      # rubocop:disable Metrics/MethodLength
      def initialize(user_options = {})
        options = if user_options.respond_to?(:to_i)
                    { open_flow_header: { transaction_id: user_options.to_i } }
                  elsif user_options.respond_to?(:fetch)
                    transaction_id =
                      user_options[:transaction_id] || user_options[:xid] || 0
                    { open_flow_header: { transaction_id: transaction_id },
                      body: user_options[:user_data] }
                  else
                    fail TypeError
                  end
        @format = self.class.const_get(:Format).new(options)
      end
      # rubocop:enable Metrics/MethodLength
    end
  end
end
