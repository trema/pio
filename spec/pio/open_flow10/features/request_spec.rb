require 'pio/open_flow10/features/request.rb'

describe Pio::OpenFlow10::Features::Request do
  describe '.new' do
    it_should_behave_like('an OpenFlow message',
                          Pio::OpenFlow10::Features::Request)

    context "with body: 'abcde'" do
      When(:message) { Pio::OpenFlow10::Features::Request.new(body: 'abcde') }
      Then { message == Failure(RuntimeError, 'Unknown option: body') }
    end
  end
end
