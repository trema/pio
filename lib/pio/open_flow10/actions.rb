require 'bindata'
require 'pio/open_flow10/enqueue'
require 'pio/open_flow10/send_out_port'
require 'pio/open_flow10/set_destination_ip_address'
require 'pio/open_flow10/set_destination_mac_address'
require 'pio/open_flow10/set_source_ip_address'
require 'pio/open_flow10/set_source_mac_address'
require 'pio/open_flow10/set_tos'
require 'pio/open_flow10/set_transport_port'
require 'pio/open_flow10/set_vlan_priority'
require 'pio/open_flow10/set_vlan_vid'
require 'pio/open_flow10/strip_vlan_header'
require 'pio/open_flow10/vendor_action'

module Pio
  module OpenFlow
    # Actions list.
    class Actions < BinData::Primitive
      ACTION_CLASS = {
        0 => Pio::OpenFlow10::SendOutPort,
        1 => Pio::OpenFlow10::SetVlanVid,
        2 => Pio::OpenFlow10::SetVlanPriority,
        3 => Pio::OpenFlow10::StripVlanHeader,
        4 => Pio::OpenFlow10::SetSourceMacAddress,
        5 => Pio::OpenFlow10::SetDestinationMacAddress,
        6 => Pio::OpenFlow10::SetSourceIpAddress,
        7 => Pio::OpenFlow10::SetDestinationIpAddress,
        8 => Pio::OpenFlow10::SetTos,
        9 => Pio::OpenFlow10::SetTransportSourcePort,
        10 => Pio::OpenFlow10::SetTransportDestinationPort,
        11 => Pio::OpenFlow10::Enqueue,
        0xffff => Pio::VendorAction
      }

      mandatory_parameter :length

      endian :big

      string :binary, read_length: :length

      def set(actions)
        self.binary = Array(actions).map(&:to_binary).join
      end

      # rubocop:disable MethodLength
      # This method smells of :reek:TooManyStatements
      def get
        actions = []
        tmp = binary
        while tmp.length > 0
          type = BinData::Uint16be.read(tmp)
          begin
            action = ACTION_CLASS.fetch(type).read(tmp)
            tmp = tmp[action.action_length..-1]
            actions << action
          rescue KeyError
            raise "action type #{type} is not supported."
          end
        end
        actions
      end
      # rubocop:enable MethodLength

      def [](index)
        get[index]
      end
    end
  end
end
