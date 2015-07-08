require 'pio/open_flow10/echo'

describe Pio::Echo::Reply do
  describe '.new' do
    it_should_behave_like('an OpenFlow message', Pio::Echo::Reply)
  end
end
