require 'pio/open_flow13/features/request'

describe Pio::OpenFlow13::Features::Request do
  describe '.new' do
    it_should_behave_like('an OpenFlow message',
                          Pio::OpenFlow13::Features::Request)

    context "with unknown_opt: 'abcde'" do
      When(:message) do
        Pio::OpenFlow13::Features::Request.new(unknown_opt: 'abcde')
      end
      Then { message == Failure(RuntimeError, 'Unknown option: unknown_opt') }
    end
  end
end
