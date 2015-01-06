require 'pio/enqueue'

describe Pio::Enqueue do
  describe '.new' do
    context 'with port_number: 1, queue_id: 2' do
      When(:enqueue) { Pio::Enqueue.new(port_number: 1, queue_id: 2) }

      describe '#port_number' do
        Then { enqueue.port_number == 1 }
      end

      describe '#queue_id' do
        Then { enqueue.queue_id == 2 }
      end

      describe '#type' do
        Then { enqueue.type == 11 }
      end

      describe '#message_length' do
        Then { enqueue.message_length == 16 }
      end

      describe '#to_binary' do
        Then { enqueue.to_binary.length == 16 }
      end
    end

    context 'with port_number: :in_port, queue_id: 2' do
      When(:enqueue) { Pio::Enqueue.new(port_number: :in_port, queue_id: 2) }

      describe '#port_number' do
        Then { enqueue.port_number == :in_port }
      end
    end

    context 'with port_number: :local, queue_id: 2' do
      When(:enqueue) { Pio::Enqueue.new(port_number: :local, queue_id: 2) }
      Then { enqueue == Failure(ArgumentError) }
    end

    context 'with port_number: -1, queue_id: 2' do
      When(:enqueue) { Pio::Enqueue.new(port_number: -1, queue_id: 2) }
      Then { enqueue == Failure(ArgumentError) }
    end

    context 'with port_number: 0xff00, queue_id: 2' do
      When(:enqueue) { Pio::Enqueue.new(port_number: 0xff00, queue_id: 2) }
      Then { enqueue == Failure(ArgumentError) }
    end

    context 'with port_number: 1, queue_id: -2' do
      When(:enqueue) { Pio::Enqueue.new(port_number: 1, queue_id: -2) }
      Then { enqueue == Failure(ArgumentError) }
    end

    context 'with port_number: 1' do
      When(:enqueue) { Pio::Enqueue.new(port_number: 1) }
      Then { enqueue == Failure(ArgumentError) }
    end

    context 'with queue_id: 2' do
      When(:enqueue) { Pio::Enqueue.new(queue_id: 2) }
      Then { enqueue == Failure(ArgumentError) }
    end
  end
end
