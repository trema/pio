# frozen_string_literal: true

require 'pio/open_flow13/goto_table'

describe Pio::OpenFlow13::GotoTable do
  describe '.new' do
    When(:goto_table) { Pio::OpenFlow13::GotoTable.new(options) }

    context 'with 1' do
      Given(:options) { 1 }
      Then { goto_table.table_id == 1 }
    end
  end
end
