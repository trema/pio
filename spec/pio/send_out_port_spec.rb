require 'pio/send_out_port'

describe Pio::SendOutPort do
  describe '.new' do
    When(:send_out_port) do
      Pio::SendOutPort.new(options)
    end

    context 'with an integer' do
      When(:options) { 1 }

      Then { send_out_port.port_number == 1 }
      Then { send_out_port.max_len == 2**16 - 1 }
    end

    context 'with 0' do
      When(:options) { 0 }

      Then do
        send_out_port ==
          Failure(ArgumentError, 'The port_number should be > 0')
      end
    end

    context 'with 0xff01 (OFPP_MAX + 1)' do
      When(:options) { 0xff01 }

      Then do
        send_out_port ==
          Failure(ArgumentError, 'The port_number should be < 0xff00')
      end
    end

    context 'with :in_port' do
      When(:options) { :in_port }

      Then { send_out_port.port_number == :in_port }
    end

    context 'with :table' do
      When(:options) { :table }

      Then { send_out_port.port_number == :table }
    end

    context 'with :normal' do
      When(:options) { :normal }

      Then { send_out_port.port_number == :normal }
    end

    context 'with :flood' do
      When(:options) { :flood }

      Then { send_out_port.port_number == :flood }
    end

    context 'with :all' do
      When(:options) { :all }

      Then { send_out_port.port_number == :all }
    end

    context 'with :controller' do
      When(:options) { :controller }

      Then { send_out_port.port_number == :controller }
    end

    context 'with :controller' do
      When(:options) { :local }

      Then { send_out_port.port_number == :local }
    end

    context 'with :controller' do
      When(:options) { :none }

      Then { send_out_port.port_number == :none }
    end

    context 'with port_number: NUMBER option' do
      When(:options) { { port_number: 1 } }

      Then { send_out_port.port_number == 1 }
    end

    context 'with port_number: SYMBOL option' do
      When(:options) { { port_number: :flood } }

      Then { send_out_port.port_number == :flood }
    end

    context 'with port_number: and max_len: option' do
      When(:options) { { port_number: 1, max_len: 256 } }

      Then { send_out_port.port_number == 1 }
      Then { send_out_port.max_len == 256 }
    end

    context 'with invalid max_len: (-1) option' do
      When(:options) { { port_number: 1, max_len: -1 } }

      Then do
        send_out_port ==
          Failure(ArgumentError,
                  'The max_len should be an unsigned 16bit integer.')
      end
    end

    context 'with invalid max_len: (2**16) option' do
      When(:options) { { port_number: 1, max_len: 2**16 } }

      Then do
        send_out_port ==
          Failure(ArgumentError,
                  'The max_len should be an unsigned 16bit integer.')
      end
    end
  end
end
