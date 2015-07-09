require 'pio/open_flow13/echo'

describe Pio::OpenFlow13::Echo::Request do
  describe '.new' do
    it_should_behave_like('an OpenFlow message', Pio::OpenFlow13::Echo::Request)
  end
end
