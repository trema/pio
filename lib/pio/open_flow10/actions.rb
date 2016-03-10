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
    class Actions10 < BinData::Primitive
      ACTION_CLASS = {
        0 => OpenFlow10::SendOutPort,
        1 => OpenFlow10::SetVlanVid,
        2 => OpenFlow10::SetVlanPriority,
        3 => OpenFlow10::StripVlanHeader,
        4 => OpenFlow10::SetSourceMacAddress,
        5 => OpenFlow10::SetDestinationMacAddress,
        6 => OpenFlow10::SetSourceIpAddress,
        7 => OpenFlow10::SetDestinationIpAddress,
        8 => OpenFlow10::SetTos,
        9 => OpenFlow10::SetTransportSourcePort,
        10 => OpenFlow10::SetTransportDestinationPort,
        11 => OpenFlow10::Enqueue,
        0xffff => OpenFlow10::VendorAction
      }.freeze

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
        until tmp.empty?
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
