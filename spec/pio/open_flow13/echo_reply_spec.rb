require 'pio/open_flow13/echo/reply'

describe Pio::OpenFlow13::Echo::Reply do
  describe '.new' do
    it_should_behave_like('an OpenFlow message', Pio::OpenFlow13::Echo::Reply)
  end
end
