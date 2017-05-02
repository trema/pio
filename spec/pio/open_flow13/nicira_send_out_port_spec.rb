# frozen_string_literal: true

require 'pio/open_flow13/nicira_send_out_port'

describe Pio::OpenFlow13::NiciraSendOutPort do
  describe '.new' do
    When(:nicira_send_out_port) do
      Pio::OpenFlow13::NiciraSendOutPort.new(source)
    end

    context 'with :reg0' do
      Given(:source) { :reg0 }

      Invariant do
        nicira_send_out_port.n_bits ==
          nicira_send_out_port._source[:oxm_length] * 8
      end

      Then { nicira_send_out_port.action_type == 0xffff }
      Then { nicira_send_out_port.action_length == 24 }
      Then { nicira_send_out_port.vendor == 0x2320 }
      Then { nicira_send_out_port.subtype == 15 }
      Then { nicira_send_out_port.offset.zero? }
      Then { nicira_send_out_port.n_bits == 32 }
      Then { nicira_send_out_port.source == :reg0 }
      Then { nicira_send_out_port._source[:oxm_class] == 1 }
      Then { nicira_send_out_port._source[:oxm_field].zero? }
      Then { nicira_send_out_port._source[:oxm_length] == 4 }
    end
  end
end
