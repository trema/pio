require 'pio/open_flow10/hello'

describe Pio::Hello do
  describe '.new' do
    it_should_behave_like('an OpenFlow message', Pio::Hello)
  end
end
