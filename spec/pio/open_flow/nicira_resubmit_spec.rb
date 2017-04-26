require 'pio/open_flow/nicira_resubmit'

describe Pio::OpenFlow::NiciraResubmit do
  describe '.new' do
    When(:nicira_resubmit) do
      Pio::OpenFlow::NiciraResubmit.new(port_number)
    end

    context 'with 1' do
      Given(:port_number) { 1 }

      Then { nicira_resubmit.action_type == 0xffff }
      Then { nicira_resubmit.action_length == 16 }
      Then { nicira_resubmit.vendor == 0x2320 }
      Then { nicira_resubmit.subtype == 1 }
      Then { nicira_resubmit.in_port == 1 }
    end
  end
end
