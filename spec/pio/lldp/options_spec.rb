require 'pio'

describe Pio::Lldp::Options, '.new' do
  def options_with(user_options)
    Pio::Lldp::Options.new(user_options)
  end

  Given(:mandatory_options) do
    {
      dpid: 0x192fa7b28d,
      port_number: 1
    }
  end

  context 'with :dpid and :port_number' do
    Given(:options) { options_with(mandatory_options) }

    describe '#to_hash' do
      When(:result) { options.to_hash }

      Then { result[:chassis_id] == 0x192fa7b28d }
      Then { result[:port_id] == 1 }
      Then do
        result[:destination_mac] ==
          Pio::Mac.new(Pio::Lldp::Options::DEFAULT_DESTINATION_MAC)
      end
      Then do
        result[:source_mac] ==
          Pio::Mac.new(Pio::Lldp::Options::DEFAULT_SOURCE_MAC)
      end
    end

    context 'with :destination_mac' do
      Given(:options) do
        user_options =
          mandatory_options.update(destination_mac: '06:05:04:03:02:01')
        options_with(user_options)
      end

      describe '#to_hash' do
        When(:result) do
          options.to_hash
        end

        Then { result[:destination_mac] == Pio::Mac.new('06:05:04:03:02:01') }
        And { result[:chassis_id] == 0x192fa7b28d }
        And { result[:port_id] == 1 }
        And do
          result[:source_mac] ==
            Pio::Mac.new(Pio::Lldp::Options::DEFAULT_SOURCE_MAC)
        end
      end
    end

    context 'with :source_mac' do
      Given(:options) do
        user_options =
          mandatory_options.update(source_mac: '06:05:04:03:02:01')
        options_with(user_options)
      end

      describe '#to_hash' do
        When(:result) do
          options.to_hash
        end

        Then { result[:source_mac] == Pio::Mac.new('06:05:04:03:02:01') }
        And { result[:chassis_id] == 0x192fa7b28d }
        And { result[:port_id] == 1 }
        And do
          result[:destination_mac] ==
            Pio::Mac.new(Pio::Lldp::Options::DEFAULT_DESTINATION_MAC)
        end
      end
    end

    context 'with :destination_mac = nil' do
      Given(:options) do
        user_options = mandatory_options.update(destination_mac: nil)
        options_with(user_options)
      end

      describe '#to_hash' do
        When(:result) do
          options.to_hash
        end

        Then do
          result[:destination_mac] ==
            Pio::Mac.new(Pio::Lldp::Options::DEFAULT_DESTINATION_MAC)
        end
        And { result[:chassis_id] == 0x192fa7b28d }
        And { result[:port_id] == 1 }
        And do
          result[:source_mac] ==
            Pio::Mac.new(Pio::Lldp::Options::DEFAULT_SOURCE_MAC)
        end
      end
    end

    context 'with :source_mac = nil' do
      Given(:options) do
        user_options = mandatory_options.update(source_mac: nil)
        options_with(user_options)
      end

      describe '#to_hash' do
        When(:result) do
          options.to_hash
        end

        Then do
          result[:source_mac] ==
            Pio::Mac.new(Pio::Lldp::Options::DEFAULT_SOURCE_MAC)
        end
        And { result[:chassis_id] == 0x192fa7b28d }
        And { result[:port_id] == 1 }
        And do
          result[:destination_mac] ==
            Pio::Mac.new(Pio::Lldp::Options::DEFAULT_DESTINATION_MAC)
        end
      end
    end
  end

  context 'when :dpid is not passed' do
    Given(:user_options) do
      mandatory_options.delete(:dpid)
      mandatory_options
    end

    When(:result) do
      options_with(user_options)
    end

    Then do
      result ==
        Failure(ArgumentError, 'The dpid option should be passed.')
    end
  end

  context 'with :dpid = nil' do
    Given(:user_options) do
      mandatory_options.update(dpid: nil)
    end

    When(:result) do
      options_with(user_options)
    end

    Then do
      result == Failure(ArgumentError, "The dpid option shouldn't be nil.")
    end
  end

  context 'when :port_number is not passed' do
    Given(:user_options) do
      mandatory_options.delete(:port_number)
      mandatory_options
    end

    When(:result) do
      options_with(user_options)
    end

    Then do
      result ==
        Failure(ArgumentError, 'The port_number option should be passed.')
    end
  end

  context 'with :port_number = nil' do
    Given(:user_options) do
      mandatory_options.update(port_number: nil)
    end

    When(:result) do
      options_with(user_options)
    end

    Then do
      result ==
        Failure(ArgumentError, "The port_number option shouldn't be nil.")
    end
  end
end
