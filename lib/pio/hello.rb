# encoding: utf-8

require 'forwardable'
require 'pio/hello/format'

module Pio
  # OpenFlow 1.0 Hello message
  class Hello
    extend Forwardable

    def_delegators :@data, :version
    def_delegators :@data, :message_type
    def_delegators :@data, :message_length
    def_delegators :@data, :transaction_id
    def_delegator :@data, :transaction_id, :xid
    def_delegators :@data, :body
    def_delegators :@data, :to_binary_s

    def self.read(raw_data)
      hello = allocate
      hello.instance_variable_set :@data, Format.read(raw_data)
      hello
    end

    def initialize(user_options = {})
      options = user_options.dup
      options[:transaction_id] ||= options[:xid]
      @data = Format.new(options)
    end
  end
end
