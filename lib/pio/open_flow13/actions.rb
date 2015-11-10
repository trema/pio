require 'bindata'

module Pio
  # Actions not yet implemented.
  class UnsupportedAction < BinData::Record
    endian :big

    uint16 :action_type
    uint16 :action_length
    string :body, length: -> { action_length - 4 }

    def to_binary
      to_binary_s
    end
  end

  # Actions list of actions-apply instruction.
  class Actions < BinData::Primitive
    mandatory_parameter :length

    endian :big

    string :binary, read_length: :length

    def set(actions)
      self.binary = Array(actions).map(&:to_binary).join
    end

    # rubocop:disable MethodLength
    def get
      actions = []
      tmp = binary
      while tmp.length > 0
        action = case BinData::Uint16be.read(tmp)
                 when 0
                   SendOutPort.read(tmp)
                 else
                   UnsupportedAction.read(tmp)
                 end
        tmp = tmp[action.action_length..-1]
        actions << action
      end
      actions
    end
    # rubocop:enable MethodLength
  end
end
