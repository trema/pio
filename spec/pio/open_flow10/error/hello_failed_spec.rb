require 'pio/open_flow10/error/hello_failed'

describe Pio::OpenFlow10::Error::HelloFailed do
  it_should_behave_like('an OpenFlow message',
                        Pio::OpenFlow10::Error::HelloFailed)

  describe '.new' do
    When(:hello_failed) { Pio::OpenFlow10::Error::HelloFailed.new(options) }

    context 'with {}' do
      Given(:options) { {} }

      Then { hello_failed.message_length == 12 }
      Then { hello_failed.error_type == :hello_failed }
      Then { hello_failed.error_code == :incompatible }
      Then { hello_failed.description == '' }
    end

    context "with description: 'error description'" do
      Given(:options) { { description: 'error description' } }

      Then { hello_failed.message_length == 29 }
      Then { hello_failed.description == 'error description' }
    end
  end
end
