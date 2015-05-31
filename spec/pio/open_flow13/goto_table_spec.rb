require 'pio/open_flow13/goto_table'

describe Pio::GotoTable do
  describe '.new' do
    When(:goto_table) { Pio::GotoTable.new(options) }

    context 'with 1' do
      Given(:options) { 1 }
      Then { goto_table.table_id == 1 }
    end
  end
end
