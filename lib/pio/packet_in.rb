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
  end
end
