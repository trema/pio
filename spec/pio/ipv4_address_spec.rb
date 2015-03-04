require 'pio/ipv4_address'

describe Pio::IPv4Address do
  Given(:ipv4) { Pio::IPv4Address.new(ip_address) }

  context ".new('192.168.1.10')" do
    Given(:ip_address) { '192.168.1.10' }

    describe '#to_s' do
      When(:result) { ipv4.to_s }
      Then { result == '192.168.1.10' }
    end

    describe '#to_i' do
      When(:result) { ipv4.to_i }
      Then { result == (((192 * 256 + 168) * 256 + 1) * 256 + 10) }
    end

    describe '#to_range' do
      When(:result) { ipv4.to_range }
      Then { result == (ipv4..ipv4) }
    end

    describe '#==' do
      When(:result) { ipv4 == other }

      context "with an IPv4Address ('192.168.1.10)" do
        When(:other) { Pio::IPv4Address.new('192.168.1.10') }
        Then { result == true }
      end

      context "with an IPv4Address ('192.168.1.10/255.255.0.0)" do
        When(:other) { Pio::IPv4Address.new('192.168.1.10/255.255.0.0') }
        Then { result == false }
      end

      context "with an IPv4Address ('10.0.1.1')" do
        When(:other) { Pio::IPv4Address.new('10.0.1.1') }
        Then { result == false }
      end
    end

    describe '#eql?' do
      When(:result) { ipv4.eql? other }

      context "with an IPv4Address ('192.168.1.10)" do
        When(:other) { Pio::IPv4Address.new('192.168.1.10') }
        Then { result == true }
      end

      context "with an IPv4Address ('192.168.1.10/255.255.0.0)" do
        When(:other) { Pio::IPv4Address.new('192.168.1.10/255.255.0.0') }
        Then { result == false }
      end

      context "with an IPv4Address ('10.0.1.1')" do
        When(:other) { Pio::IPv4Address.new('10.0.1.1') }
        Then { result == false }
      end
    end

    describe '#hash' do
      When(:result) { ipv4.hash }
      Then { result == Pio::IPv4Address.new('192.168.1.10').hash }
      Then { result != Pio::IPv4Address.new('192.168.1.10/255.255.0.0').hash }
      Then { result != Pio::IPv4Address.new('10.0.1.1').hash }
    end

    describe '#to_a' do
      When(:result) { ipv4.to_a }
      Then { result == [192, 168, 1, 10] }
    end

    describe '#to_ary' do
      When(:result) { ipv4.to_ary }
      Then { result == [192, 168, 1, 10] }
    end

    describe '#mask' do
      When(:result) { ipv4.mask(masklen) }

      context 'with 8' do
        Given(:masklen) { 8 }
        Then { result.to_s == '192.0.0.0' }
      end

      context 'with 16' do
        Given(:masklen) { 16 }
        Then { result.to_s == '192.168.0.0' }
      end

      context 'with 24' do
        Given(:masklen) { 24 }
        Then { result.to_s == '192.168.1.0' }
      end
    end
  end

  describe '#class_a?' do
    When(:result) { ipv4.class_a? }

    context 'when IP address = 192.168.0.1' do
      Given(:ip_address) { '192.168.0.1' }
      Then { result == false }
    end

    context 'when IP address = 0.0.0.0' do
      Given(:ip_address) { '0.0.0.0' }
      Then { result == true }
    end

    context 'when IP address = 127.255.255.255' do
      Given(:ip_address) { '127.255.255.255' }
      Then { result == true }
    end
  end

  describe '#class_b?' do
    When(:result) { ipv4.class_b? }

    context 'when IP address = 223.255.255.255' do
      Given(:ip_address) { '223.255.255.255' }
      Then { result == false }
    end

    context 'when IP address = 128.0.0.0' do
      Given(:ip_address) { '128.0.0.0' }
      Then { result == true }
    end

    context 'when IP address = 191.255.255.255' do
      Given(:ip_address) { '191.255.255.255' }
      Then { result == true }
    end
  end

  describe '#class_c?' do
    When(:result) { ipv4.class_c? }

    context 'when IP address = 10.1.1.1' do
      Given(:ip_address) { '10.1.1.1' }
      Then { result == false }
    end

    context 'when IP address = 192.0.0.0' do
      Given(:ip_address) { '192.0.0.0' }
      Then { result == true }
    end

    context 'when IP address = 223.255.255.255' do
      Given(:ip_address) { '223.255.255.255' }
      Then { result == true }
    end
  end

  describe '#class_d?' do
    When(:result) { ipv4.class_d? }

    context 'when IP address = 10.1.1.1' do
      Given(:ip_address) { '10.1.1.1' }
      Then { result == false }
    end

    context 'when IP address = 224.0.0.0' do
      Given(:ip_address) { '224.0.0.0' }
      Then { result == true }
    end

    context 'when IP address = 239.255.255.255' do
      Given(:ip_address) { '239.255.255.255' }
      Then { result == true }
    end
  end

  describe '#class_e?' do
    When(:result) { ipv4.class_e? }

    context 'when IP address = 10.1.1.1' do
      Given(:ip_address) { '10.1.1.1' }
      Then { result == false }
    end

    context 'when IP address = 240.0.0.0' do
      Given(:ip_address) { '240.0.0.0' }
      Then { result == true }
    end

    context 'when IP address = 255.255.255.255' do
      Given(:ip_address) { '255.255.255.255' }
      Then { result == true }
    end
  end

  describe '#unicast?' do
    When(:result) { ipv4.unicast? }

    context 'when IP address = 10.1.1.1' do
      Given(:ip_address) { '10.1.1.1' }
      Then { result == true }
    end

    context 'when IP address = 234.1.1.1' do
      Given(:ip_address) { '234.1.1.1' }
      Then { result == false }
    end
  end

  describe '#multicast?' do
    When(:result) { ipv4.multicast? }

    context 'when IP address = 10.1.1.1' do
      Given(:ip_address) { '10.1.1.1' }
      Then { result == false }
    end

    context 'when IP address = 234.1.1.1' do
      Given(:ip_address) { '234.1.1.1' }
      Then { result == true }
    end
  end

  describe '#prefixlen' do
    When(:result) { ipv4.prefixlen }

    context 'IP address = with 10.1.1.1' do
      Given(:ip_address) { '10.1.1.1' }
      Then { result == 32 }
    end

    context 'IP address = with 10.1.1.1/255.255.255.255' do
      Given(:ip_address) { '10.1.1.1/255.255.255.255' }
      Then { result == 32 }
    end

    context 'IP address = with 10.1.1.1/32' do
      Given(:ip_address) { '10.1.1.1/32' }
      Then { result == 32 }
    end

    context 'when IP address = 192.168.0.1/255.255.255.0' do
      Given(:ip_address) { '192.168.0.1/255.255.255.0' }
      Then { result == 24 }
    end

    context 'when IP address = 192.168.0.1/24' do
      Given(:ip_address) { '192.168.0.1/24' }
      Then { result == 24 }
    end

    context 'when IP address = 192.168.0.1/255.255.0.0' do
      Given(:ip_address) { '192.168.0.1/255.255.0.0' }
      Then { result == 16 }
    end

    context 'when IP address = 192.168.0.1/16' do
      Given(:ip_address) { '192.168.0.1/16' }
      Then { result == 16 }
    end

    context 'when IP address = 192.168.0.1/255.0.0.0' do
      Given(:ip_address) { '192.168.0.1/255.0.0.0' }
      Then { result == 8 }
    end

    context 'when IP address = 192.168.0.1/8' do
      Given(:ip_address) { '192.168.0.1/8' }
      Then { result == 8 }
    end
  end
end
