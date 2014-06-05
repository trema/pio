# encoding: utf-8

require 'pio/ipv4_address'

describe Pio::IPv4Address do
  context '.new' do
    subject(:ipv4) { Pio::IPv4Address.new(ip_address) }

    context 'with 10.1.1.1' do
      let(:ip_address) { '10.1.1.1' }

      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq '10.1.1.1' }
      end

      describe '#to_i' do
        subject { super().to_i }
        it { is_expected.to eq(((10 * 256 + 1) * 256 + 1) * 256 + 1) }
      end

      describe '#prefixlen' do
        subject { super().prefixlen }
        it { is_expected.to eq 32 }
      end

      describe '#to_ary' do
        subject { super().to_ary }
        it { is_expected.to eq [0x0a, 0x01, 0x01, 0x01] }
      end

      describe '#class_a?' do
        subject { super().class_a? }
        it { is_expected.to be_truthy }
      end

      describe '#class_b?' do
        subject { super().class_b? }
        it { is_expected.to be_falsey }
      end

      describe '#class_c?' do
        subject { super().class_c? }
        it { is_expected.to be_falsey }
      end

      describe '#class_d?' do
        subject { super().class_d? }
        it { is_expected.to be_falsey }
      end

      describe '#class_e?' do
        subject { super().class_e? }
        it { is_expected.to be_falsey }
      end

      describe '#unicast?' do
        subject { super().unicast? }
        it { is_expected.to be_truthy }
      end

      describe '#multicast?' do
        subject { super().multicast? }
        it { is_expected.to be_falsey }
      end

      context '.mask!' do
        subject { ipv4.mask!(mask) }

        let(:mask) { 8 }

        describe '#to_s' do
          subject { super().to_s }
          it { is_expected.to eq '10.0.0.0' }
        end

        describe '#to_i' do
          subject { super().to_i }
          it { is_expected.to eq 10 * 256 * 256 * 256 }
        end

        describe '#to_ary' do
          subject { super().to_ary }
          it { is_expected.to eq [0x0a, 0x00, 0x00, 0x00] }
        end

        describe '#class_a?' do
          subject { super().class_a? }
          it { is_expected.to be_truthy }
        end

        describe '#class_b?' do
          subject { super().class_b? }
          it { is_expected.to be_falsey }
        end

        describe '#class_c?' do
          subject { super().class_c? }
          it { is_expected.to be_falsey }
        end

        describe '#class_d?' do
          subject { super().class_d? }
          it { is_expected.to be_falsey }
        end

        describe '#class_e?' do
          subject { super().class_e? }
          it { is_expected.to be_falsey }
        end

        describe '#unicast?' do
          subject { super().unicast? }
          it { is_expected.to be_truthy }
        end

        describe '#multicast?' do
          subject { super().multicast? }
          it { is_expected.to be_falsey }
        end
      end
    end

    context 'with 172.20.1.1' do
      let(:ip_address) { '172.20.1.1' }

      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq '172.20.1.1' }
      end

      describe '#to_i' do
        subject { super().to_i }
        it { is_expected.to eq(((172 * 256 + 20) * 256 + 1) * 256 + 1) }
      end

      describe '#to_ary' do
        subject { super().to_ary }
        it { is_expected.to eq [0xac, 0x14, 0x01, 0x01] }
      end

      describe '#class_a?' do
        subject { super().class_a? }
        it { is_expected.to be_falsey }
      end

      describe '#class_b?' do
        subject { super().class_b? }
        it { is_expected.to be_truthy }
      end

      describe '#class_c?' do
        subject { super().class_c? }
        it { is_expected.to be_falsey }
      end

      describe '#class_d?' do
        subject { super().class_d? }
        it { is_expected.to be_falsey }
      end

      describe '#class_e?' do
        subject { super().class_e? }
        it { is_expected.to be_falsey }
      end

      describe '#unicast?' do
        subject { super().unicast? }
        it { is_expected.to be_truthy }
      end

      describe '#multicast?' do
        subject { super().multicast? }
        it { is_expected.to be_falsey }
      end
    end

    context 'with 192.168.1.1' do
      let(:ip_address) { '192.168.1.1' }

      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq '192.168.1.1' }
      end

      describe '#to_i' do
        subject { super().to_i }
        it { is_expected.to eq 3_232_235_777 }
      end

      describe '#to_ary' do
        subject { super().to_ary }
        it { is_expected.to eq [0xc0, 0xa8, 0x01, 0x01] }
      end

      describe '#class_a?' do
        subject { super().class_a? }
        it { is_expected.to be_falsey }
      end

      describe '#class_b?' do
        subject { super().class_b? }
        it { is_expected.to be_falsey }
      end

      describe '#class_c?' do
        subject { super().class_c? }
        it { is_expected.to be_truthy }
      end

      describe '#class_d?' do
        subject { super().class_d? }
        it { is_expected.to be_falsey }
      end

      describe '#class_e?' do
        subject { super().class_e? }
        it { is_expected.to be_falsey }
      end

      describe '#unicast?' do
        subject { super().unicast? }
        it { is_expected.to be_truthy }
      end

      describe '#multicast?' do
        subject { super().multicast? }
        it { is_expected.to be_falsey }
      end
    end

    context 'with 234.1.1.1' do
      let(:ip_address) { '234.1.1.1' }

      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq '234.1.1.1' }
      end

      describe '#to_i' do
        subject { super().to_i }
        it { is_expected.to eq(((234 * 256 + 1) * 256 + 1) * 256 + 1) }
      end

      describe '#to_ary' do
        subject { super().to_ary }
        it { is_expected.to eq [0xea, 0x01, 0x01, 0x01] }
      end

      describe '#class_a?' do
        subject { super().class_a? }
        it { is_expected.to be_falsey }
      end

      describe '#class_b?' do
        subject { super().class_b? }
        it { is_expected.to be_falsey }
      end

      describe '#class_c?' do
        subject { super().class_c? }
        it { is_expected.to be_falsey }
      end

      describe '#class_d?' do
        subject { super().class_d? }
        it { is_expected.to be_truthy }
      end

      describe '#class_e?' do
        subject { super().class_e? }
        it { is_expected.to be_falsey }
      end

      describe '#unicast?' do
        subject { super().unicast? }
        it { is_expected.to be_falsey }
      end

      describe '#multicast?' do
        subject { super().multicast? }
        it { is_expected.to be_truthy }
      end
    end

    context 'with 192.168.0.1/16' do
      let(:ip_address) { '192.168.0.1/16' }

      describe '#prefixlen' do
        subject { super().prefixlen }
        it { is_expected.to eq 16 }
      end
    end

    context 'with 192.168.0.1/255.255.255.0' do
      let(:ip_address) { '192.168.0.1/255.255.255.0' }

      describe '#prefixlen' do
        subject { super().prefixlen }
        it { is_expected.to eq 24 }
      end
    end
  end
end
