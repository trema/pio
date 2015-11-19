require 'pio/open_flow/nicira_resubmit_table'

describe Pio::NiciraResubmitTable do
  describe '.new' do
    When(:nicira_resubmit_table) do
      Pio::NiciraResubmitTable.new(options)
    end

    context 'with in_port: 1, table: 1' do
      Given(:options) { { in_port: 1, table: 1 } }

      Then { nicira_resubmit_table.action_type == 0xffff }
      Then { nicira_resubmit_table.action_length == 16 }
      Then { nicira_resubmit_table.vendor == 0x2320 }
      Then { nicira_resubmit_table.subtype == 14 }
      Then { nicira_resubmit_table.in_port == 1 }
      Then { nicira_resubmit_table.table == 1 }
    end
  end
end
