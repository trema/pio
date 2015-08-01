require 'pio/open_flow13/features_request'

describe Pio::OpenFlow13::Features::Request do
  describe '.new' do
    it_should_behave_like('an OpenFlow message',
                          Pio::OpenFlow13::Features::Request)

    context "with body: 'abcde'" do
      When(:message) { Pio::OpenFlow13::Features::Request.new(body: 'abcde') }
      Then { message == Failure(RuntimeError, 'Unknown option: body') }
    end
  end
end
