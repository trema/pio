# -*- coding: utf-8 -*-
require 'pio'

describe Pio::Arp::Request::Options, '.new' do
  Given(:mandatory_options) do
    {
     source_mac: 0x002682ebead1,
     sender_protocol_address: 0xc0a85303,
     target_protocol_address: 0xc0a853fe
    }
  end

  context 'with all mandatory options' do
    Given(:options) do
      Pio::Arp::Request::Options.new(mandatory_options)
    end

    describe '#to_hash' do
      When(:result) { options.to_hash }

      Then { result[:source_mac] == Pio::Mac.new(0x002682ebead1) }
      Then { result[:sender_protocol_address] == Pio::IPv4Address.new(0xc0a85303) }
      Then { result[:target_protocol_address] == Pio::IPv4Address.new(0xc0a853fe) }
    end
  end

  context 'when source_mac is not passed' do
    Given(:user_options) do
      mandatory_options.delete(:source_mac)
      mandatory_options
    end

    When(:result) { Pio::Arp::Request::Options.new(user_options) }

    Then do
      # FIXME: ArgumentError, 'The source_mac option should be passed.'
      result ==
        Failure(Pio::Mac::InvalidValueError, 'Invalid MAC address: nil')
    end
  end

  context 'with source_mac = nil' do
    Given(:user_options) do
      mandatory_options.update(source_mac: nil)
      mandatory_options
    end

    When(:result) { Pio::Arp::Request::Options.new(user_options) }

    Then do
      # FIXME: ArgumentError, "The source_mac option shouldn't be nil."
      result ==
        Failure(Pio::Mac::InvalidValueError, 'Invalid MAC address: nil')
    end
  end

  context 'when sender_protocol_address is not passed' do
    Given(:user_options) do
      mandatory_options.delete(:sender_protocol_address)
      mandatory_options
    end

    When(:result) { Pio::Arp::Request::Options.new(user_options) }

    Then do
      # FIXME: ArgumentError, 'The sender_protocol_address option should be passed.'
      result ==
        Failure(TypeError, 'Invalid IPv4 address: nil')
    end
  end

  context 'with sender_protocol_address = nil' do
    Given(:user_options) do
      mandatory_options.update(sender_protocol_address: nil)
      mandatory_options
    end

    When(:result) { Pio::Arp::Request::Options.new(user_options) }

    Then do
      # FIXME: ArgumentError, "The sender_protocol_address option shouldn't be nil."
      result ==
        Failure(TypeError, 'Invalid IPv4 address: nil')
    end
  end

  context 'when target_protocol_address is not passed' do
    Given(:user_options) do
      mandatory_options.delete(:target_protocol_address)
      mandatory_options
    end

    When(:result) { Pio::Arp::Request::Options.new(user_options) }

    Then do
      # FIXME: ArgumentError, 'The target_protocol_address option should be passed.'
      result ==
        Failure(TypeError, 'Invalid IPv4 address: nil')
    end
  end

  context 'with target_protocol_address = nil' do
    Given(:user_options) do
      mandatory_options.update(target_protocol_address: nil)
      mandatory_options
    end

    When(:result) { Pio::Arp::Request::Options.new(user_options) }

    Then do
      # FIXME: ArgumentError, "The target_protocol_address option shouldn't be nil."
      result ==
        Failure(TypeError, 'Invalid IPv4 address: nil')
    end
  end
end
