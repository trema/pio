# frozen_string_literal: true

require 'bindata'

module Pio
  module OpenFlow13
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
    class Actions13 < BinData::Primitive
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
        until tmp.empty?
          action = case BinData::Uint16be.read(tmp)
                   when 0
                     OpenFlow13::SendOutPort.read(tmp)
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
end
