require 'pio/open_flow'

describe Pio::OpenFlow do
  describe 'switch_version' do
    When(:error) { Pio::OpenFlow.switch_version(version) }

    context 'with :OpenFlow10' do
      Given(:version) { :OpenFlow10 }
      Then { Pio::OpenFlow.version == 'OpenFlow10' }
    end

    context 'with "OpenFlow10"' do
      Given(:version) { 'OpenFlow10' }
      Then { Pio::OpenFlow.version == 'OpenFlow10' }
    end

    context 'with :OpenFlow13' do
      Given(:version) { :OpenFlow13 }
      Then { Pio::OpenFlow.version == 'OpenFlow13' }
    end

    context 'with "OpenFlow13"' do
      Given(:version) { 'OpenFlow13' }
      Then { Pio::OpenFlow.version == 'OpenFlow13' }
    end

    context 'with :OpenFlow100' do
      Given(:version) { :OpenFlow100 }
      Then do
        error == Failure(RuntimeError, 'OpenFlow100 is not supported yet.')
      end
    end
  end
end
