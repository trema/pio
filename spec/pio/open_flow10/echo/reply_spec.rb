require 'pio/open_flow10/echo/reply'

describe Pio::OpenFlow10::Echo::Reply do
  describe '.new' do
    it_should_behave_like('an OpenFlow message', Pio::OpenFlow10::Echo::Reply)
  end
end
