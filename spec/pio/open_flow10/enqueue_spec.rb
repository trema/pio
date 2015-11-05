require 'pio/open_flow10/enqueue'

describe Pio::OpenFlow10::Enqueue do
  describe '.new' do
    context 'with port: 1, queue_id: 2' do
      When(:enqueue) { Pio::OpenFlow10::Enqueue.new(port: 1, queue_id: 2) }

      describe '#port' do
        Then { enqueue.port == 1 }
      end

      describe '#queue_id' do
        Then { enqueue.queue_id == 2 }
      end

      describe '#action_type' do
        Then { enqueue.action_type == 11 }
      end

      describe '#action_length' do
        Then { enqueue.action_length == 16 }
      end

      describe '#to_binary' do
        Then { enqueue.to_binary.length == 16 }
      end
    end

    context 'with port: :in_port, queue_id: 2' do
      When(:enqueue) do
        Pio::OpenFlow10::Enqueue.new(port: :in_port, queue_id: 2)
      end

      describe '#port' do
        Then { enqueue.port == :in_port }
      end
    end

    context 'with port: :local, queue_id: 2' do
      When(:enqueue) { Pio::OpenFlow10::Enqueue.new(port: :local, queue_id: 2) }
      Then { enqueue == Failure(ArgumentError) }
    end

    context 'with port: -1, queue_id: 2' do
      When(:enqueue) { Pio::OpenFlow10::Enqueue.new(port: -1, queue_id: 2) }
      Then { enqueue == Failure(ArgumentError) }
    end

    context 'with port: 0xff00, queue_id: 2' do
      When(:enqueue) { Pio::OpenFlow10::Enqueue.new(port: 0xff00, queue_id: 2) }
      Then { enqueue == Failure(ArgumentError) }
    end

    context 'with port: 1, queue_id: -2' do
      When(:enqueue) { Pio::OpenFlow10::Enqueue.new(port: 1, queue_id: -2) }
      Then { enqueue == Failure(ArgumentError) }
    end

    context 'with port: 1' do
      When(:enqueue) { Pio::OpenFlow10::Enqueue.new(port: 1) }
      Then { enqueue == Failure(ArgumentError) }
    end

    context 'with queue_id: 2' do
      When(:enqueue) { Pio::OpenFlow10::Enqueue.new(queue_id: 2) }
      Then { enqueue == Failure(ArgumentError) }
    end
  end
end
