require 'pio/open_flow10/set_tos'

describe Pio::OpenFlow10::SetTos do
  describe '.new' do
    context 'with 32' do
      When(:set_tos) { Pio::OpenFlow10::SetTos.new(32) }

      describe '#type_of_service' do
        Then { set_tos.type_of_service == 32 }
      end

      describe '#action_type' do
        Then { set_tos.action_type == 8 }
      end

      describe '#action_length' do
        Then { set_tos.action_length == 8 }
      end

      describe '#to_binary' do
        Then { set_tos.to_binary.length == 8 }
      end
    end

    context 'with 1' do
      When(:set_tos) { Pio::OpenFlow10::SetTos.new(1) }
      Then { set_tos == Failure(ArgumentError) }
    end
  end
end
