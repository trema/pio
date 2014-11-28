# encoding: utf-8

require 'forwardable'
require 'bindata'

module Pio
  class Echo
    # Base class of Echo request and reply.
    class Message
      extend Forwardable

      def_delegators :@format, :ofp_version
      def_delegators :@format, :message_type
      def_delegators :@format, :message_length
      def_delegators :@format, :transaction_id
      def_delegator :@format, :transaction_id, :xid
      def_delegator :@format, :body, :user_data
      def_delegator :@format, :to_binary_s, :to_binary

      # This method smells of :reek:FeatureEnvy
      def initialize(message_type, user_options = {})
        options = if user_options.respond_to?(:to_i)
                    { transaction_id: user_options.to_i }
                  elsif user_options.respond_to?(:fetch)
                    { body: user_options[:user_data],
                      transaction_id: user_options[:transaction_id] ||
                                      user_options[:xid] || 0 }
                  else
                    fail TypeError
                  end
        @format = Format.new(options.merge(message_type: message_type))
      end
    end
  end
end
