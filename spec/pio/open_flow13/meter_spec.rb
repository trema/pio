require 'pio/open_flow13/meter'

describe Pio::Meter do
  describe '.new' do
    When(:meter) { Pio::Meter.new(options) }

    context 'with 1' do
      Given(:options) { 1 }
      Then { meter.meter_id == 1 }
    end
  end
end
