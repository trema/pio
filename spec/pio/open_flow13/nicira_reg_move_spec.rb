require 'pio/open_flow13/nicira_reg_move'

describe Pio::OpenFlow13::NiciraRegMove do
  describe '.new' do
    When(:nicira_reg_move) do
      Pio::OpenFlow13::NiciraRegMove.new(options)
    end

    context 'with source: :arp_sender_hardware_address,'\
            ' destination: :arp_target_hardware_address' do
      Given(:options) do
        { source: :arp_sender_hardware_address,
          destination: :arp_target_hardware_address }
      end

      Invariant do
        nicira_reg_move.n_bits ==
          nicira_reg_move._source[:oxm_length] * 8
      end

      Then { nicira_reg_move.action_type == 0xffff }
      Then { nicira_reg_move.action_length == 24 }
      Then { nicira_reg_move.vendor == 0x2320 }
      Then { nicira_reg_move.subtype == 6 }
      Then { nicira_reg_move.n_bits == 48 }
      Then { nicira_reg_move.source_offset.zero? }
      Then { nicira_reg_move.destination_offset.zero? }
      Then { nicira_reg_move.source == :arp_sender_hardware_address }
      Then { nicira_reg_move._source[:oxm_class] == 0x8000 }
      Then { nicira_reg_move._source[:oxm_field] == 24 }
      Then { nicira_reg_move._source[:oxm_hasmask].zero? }
      Then { nicira_reg_move._source[:oxm_length] == 6 }
      Then { nicira_reg_move.destination == :arp_target_hardware_address }
      Then { nicira_reg_move._destination[:oxm_class] == 0x8000 }
      Then { nicira_reg_move._destination[:oxm_field] == 25 }
      Then { nicira_reg_move._destination[:oxm_hasmask].zero? }
      Then { nicira_reg_move._destination[:oxm_length] == 6 }
    end
  end
end
