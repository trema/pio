require 'bindata'

module Pio
  class Echo
    # OpenFlow 1.0 Echo message.
    class Message < BinData::Record
      endian :big

      uint8 :version
      uint8 :message_type
      uint16 :message_length
      uint32 :transaction_id
      string :data

      def xid
        transaction_id
      end
    end
  end
end
