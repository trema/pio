require 'pio/open_flow10/features'

describe Pio::Features::Request do
  describe '.new' do
    it_should_behave_like('an OpenFlow message', Pio::Features::Request)

    context "with body: 'abcde'" do
      When(:message) { Pio::Features::Request.new(body: 'abcde') }
      Then { message == Failure(RuntimeError, 'Unknown option: body') }
    end
  end
end
