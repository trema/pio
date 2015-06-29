module Pio
  # Buffered packet to apply to, or :no_buffer.
  class BufferId < BinData::Primitive
    NO_BUFFER = 0xffffffff

    endian :big
    uint32 :buffer_id, initial_value: NO_BUFFER

    def get
      (buffer_id == NO_BUFFER) ? :no_buffer : buffer_id
    end

    def set(value)
      self.buffer_id = (value == :no_buffer ? NO_BUFFER : value)
    end
  end
end
