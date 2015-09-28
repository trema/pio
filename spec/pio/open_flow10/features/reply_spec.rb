require 'pio/open_flow10/features/reply'

describe Pio::OpenFlow10::Features::Reply do
  describe '.new' do
    it_should_behave_like('an OpenFlow message with Datapath ID',
                          Pio::OpenFlow10::Features::Reply)
  end
end
