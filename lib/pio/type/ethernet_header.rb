require 'pio/type/mac_address'

module Pio
  module Type
    # Adds ethernet_header macro.
    module EthernetHeader
      ETHER_TYPE_IP = 0x0800

      # rubocop:disable MethodLength
      # rubocop:disable AbcSize
      def ethernet_header(options = { ether_type: 0x0800 })
        class_eval do
          mac_address :destination_mac
          mac_address :source_mac
          uint16 :ether_type_internal, initial_value: options[:ether_type]

          bit3 :vlan_pcp_internal, onlyif: -> { vlan? }
          bit1 :vlan_cfi, onlyif: -> { vlan? }
          bit12 :vlan_vid_internal, onlyif: -> { vlan? }

          uint16 :ether_type_vlan, onlyif: -> { vlan? },
                                   initial_value: options[:ether_type]

          def ether_type
            ether_type_internal
          end

          def vlan_vid
            vlan? ? vlan_vid_internal : 0xffff
          end

          def vlan_pcp
            vlan? ? vlan_pcp_internal : 0
          end

          def vlan?
            ether_type == 0x8100
          end
        end
      end
      # rubocop:enable MethodLength
      # rubocop:enable AbcSize
    end
  end
end
