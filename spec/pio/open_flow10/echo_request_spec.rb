require 'pio/open_flow10/echo'

describe Pio::Echo::Request do
  describe '.new' do
    it_should_behave_like('an OpenFlow message', Pio::Echo::Request)
  end
end
