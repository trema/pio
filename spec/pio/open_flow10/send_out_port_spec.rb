require 'pio/open_flow10/send_out_port'

describe Pio::OpenFlow10::SendOutPort do
  describe '.new' do
    When(:send_out_port) { Pio::OpenFlow10::SendOutPort.new(options) }

    context 'with 1' do
      Given(:options) { 1 }
      Then { send_out_port.port == 1 }
      Then { send_out_port.max_length == 2**16 - 1 }

      describe '#==' do
        When(:result) { send_out_port == other }

        context 'with SendOutPort.new(1)' do
          Given(:other) { Pio::OpenFlow10::SendOutPort.new(1) }
          Then { result == true }
        end

        context 'with SendOutPort.new(2)' do
          Given(:other) { Pio::OpenFlow10::SendOutPort.new(2) }
          Then { result == false }
        end
      end
    end

    context 'with 0' do
      Given(:options) { 0 }
      Then do
        send_out_port ==
          Failure(ArgumentError, 'The port should be > 0')
      end
    end

    context 'with 0xff01 (OFPP_MAX + 1)' do
      Given(:options) { 0xff01 }
      Then do
        send_out_port ==
          Failure(ArgumentError, 'The port should be < 0xff00')
      end
    end

    context 'with :in_port' do
      Given(:options) { :in_port }
      Then { send_out_port.port == :in_port }
    end

    context 'with :table' do
      Given(:options) { :table }
      Then { send_out_port.port == :table }
    end

    context 'with :normal' do
      Given(:options) { :normal }
      Then { send_out_port.port == :normal }
    end

    context 'with :flood' do
      Given(:options) { :flood }
      Then { send_out_port.port == :flood }
    end

    context 'with :all' do
      Given(:options) { :all }
      Then { send_out_port.port == :all }
    end

    context 'with :controller' do
      Given(:options) { :controller }
      Then { send_out_port.port == :controller }
    end

    context 'with :controller' do
      Given(:options) { :local }
      Then { send_out_port.port == :local }
    end

    context 'with :controller' do
      Given(:options) { :none }
      Then { send_out_port.port == :none }
    end

    context 'with port: NUMBER option' do
      Given(:options) { { port: 1 } }
      Then { send_out_port.port == 1 }
    end

    context 'with port: SYMBOL option' do
      Given(:options) { { port: :flood } }
      Then { send_out_port.port == :flood }
    end

    context 'with port: and max_length: option' do
      Given(:options) { { port: 1, max_length: 256 } }
      Then { send_out_port.port == 1 }
      Then { send_out_port.max_length == 256 }
    end

    context 'with invalid max_length: (-1) option' do
      Given(:options) { { port: 1, max_length: -1 } }
      Then do
        send_out_port ==
          Failure(ArgumentError,
                  'The max_length should be an unsigned 16bit integer.')
      end
    end

    context 'with invalid max_length: (2**16) option' do
      Given(:options) { { port: 1, max_length: 2**16 } }
      Then do
        send_out_port ==
          Failure(ArgumentError,
                  'The max_length should be an unsigned 16bit integer.')
      end
    end
  end
end
