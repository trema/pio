require 'pio/open_flow10/features/request.rb'

describe Pio::OpenFlow10::Features::Request do
  describe '.new' do
    it_should_behave_like('an OpenFlow message',
                          Pio::OpenFlow10::Features::Request)
  end
end
