# encoding: utf-8

require 'forwardable'

module Pio
  # OpenFlow 1.0 Features messages
  class Features
    # OpenFlow 1.0 Features Request message
    class Request
      extend Forwardable

      def_delegators :@features, :version
      def_delegators :@features, :message_type
      def_delegators :@features, :message_length
      def_delegators :@features, :transaction_id
      def_delegator :@features, :transaction_id, :xid
      def_delegators :@features, :body
      def_delegator :@features, :to_binary_s, :to_binary

      def self.create_from(features)
        message = allocate
        message.instance_variable_set :@features, features
        message
      end

      def initialize(user_options = {})
        if user_options.respond_to?(:to_i)
          @options = { transaction_id: user_options.to_i,
                       message_type: 5 }
        elsif user_options.respond_to?(:[])
          @options = user_options.dup.merge(message_type: 5)
          handle_user_hash_options
        else
          fail TypeError
        end
        @features = Format.new(@options)
      end

      private

      def handle_user_hash_options
        @options[:transaction_id] ||= @options[:xid]
        @options[:transaction_id] = 0 unless @options[:transaction_id]
      end
    end
  end
end
