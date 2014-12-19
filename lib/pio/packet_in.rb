require 'pio/packet_in/format'

module Pio
  # OpenFlow 1.0 Packet-In message
  class PacketIn
    def self.read(raw_data)
      packet_in = allocate
      packet_in.instance_variable_set :@format, Format.read(raw_data)
      packet_in
    end

    def_delegators :body, :buffer_id
    def_delegators :body, :total_len
    def_delegators :body, :in_port
    def_delegators :body, :reason
    def_delegators :body, :data

    # @reek This method smells of :reek:FeatureEnvy
    def initialize(user_options)
      header_options = { transaction_id: user_options[:transaction_id] ||
                                         user_options[:xid] || 0 }
      @format = Format.new(open_flow_header: header_options, body: user_options)
    end
  end
end
