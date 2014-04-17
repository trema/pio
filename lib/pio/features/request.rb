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

      def self.create_from(features)
        message = allocate
        message.instance_variable_set :@features, features
        message
      end
    end
  end
end
