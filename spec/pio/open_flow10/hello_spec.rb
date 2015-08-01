require 'pio/open_flow10/hello'

describe Pio::OpenFlow10::Hello do
  describe '.new' do
    it_should_behave_like('an OpenFlow message', Pio::OpenFlow10::Hello)
  end
end
