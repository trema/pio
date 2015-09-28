require 'pio/open_flow13/features/reply'

describe Pio::OpenFlow13::Features::Reply do
  describe '.new' do
    it_should_behave_like('an OpenFlow message with Datapath ID',
                          Pio::OpenFlow13::Features::Reply)
  end
end
