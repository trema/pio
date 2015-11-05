require 'pio/open_flow10/echo/request'

describe Pio::OpenFlow10::Echo::Request do
  describe '.new' do
    it_should_behave_like('an OpenFlow message', Pio::OpenFlow10::Echo::Request)
  end
end
