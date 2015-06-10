require 'pio/mac'

describe Pio::Mac do
  context '.new' do
    subject { Pio::Mac.new(value) }

    context 'with "11:22:33:44:55:66"' do
      let(:value) { '11:22:33:44:55:66' }

      describe '#==' do
        it { is_expected.to eq Pio::Mac.new('11:22:33:44:55:66') }
        it { is_expected.to eq '11:22:33:44:55:66' }
        it { is_expected.not_to eq Pio::Mac.new('66:55:44:33:22:11') }
        it { is_expected.not_to eq '66:55:44:33:22:11' }
        it { is_expected.not_to eq 0x112233445566 }
        it { is_expected.not_to eq 'INVALID_MAC_ADDRESS' }
      end

      describe '#eql?' do
        it { expect(subject).to eql Pio::Mac.new('11:22:33:44:55:66') }
        it { expect(subject).to eql '11:22:33:44:55:66' }
        it { expect(subject).not_to eql Pio::Mac.new('66:55:44:33:22:11') }
        it { expect(subject).not_to eql '66:55:44:33:22:11' }
        it { expect(subject).not_to eql 0x112233445566 }
        it { expect(subject).not_to eql 'INVALID_MAC_ADDRESS' }
      end

      describe '#hash' do
        subject { super().hash }
        it { is_expected.to eq Pio::Mac.new('11:22:33:44:55:66').hash }
      end

      describe '#to_i' do
        subject { super().to_i }
        it { is_expected.to eq 0x112233445566 }
      end

      describe '#to_a' do
        subject { super().to_a }
        it { is_expected.to eq [0x11, 0x22, 0x33, 0x44, 0x55, 0x66] }
      end

      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq '11:22:33:44:55:66' }
      end

      describe '#to_str' do
        context 'when "MAC = " + subject' do
          it { expect('MAC = ' + subject).to eq 'MAC = 11:22:33:44:55:66' }
        end
      end

      describe '#multicast?' do
        subject { super().multicast? }
        it { is_expected.to be_truthy }
      end

      describe '#broadcast?' do
        subject { super().broadcast? }
        it { is_expected.to be_falsey }
      end

      describe '#reserved?' do
        subject { super().reserved? }
        it { is_expected.to be_falsey }
      end
    end

    context 'with "1122.3344.5566" (Cisco style)' do
      let(:value) { '1122.3344.5566' }

      describe '#==' do
        it { is_expected.to eq Pio::Mac.new('1122.3344.5566') }
        it { is_expected.to eq Pio::Mac.new('11:22:33:44:55:66') }
        it { is_expected.to eq '1122.3344.5566' }
        it { is_expected.to eq '11:22:33:44:55:66' }
        it { is_expected.not_to eq Pio::Mac.new('6655.4433.2211') }
        it { is_expected.not_to eq Pio::Mac.new('66:55:44:33:22:11') }
        it { is_expected.not_to eq '6655.4433.2211' }
        it { is_expected.not_to eq '66:55:44:33:22:11' }
        it { is_expected.not_to eq 0x112233445566 }
        it { is_expected.not_to eq 'INVALID_MAC_ADDRESS' }
      end

      describe '#eql?' do
        it { expect(subject).to eql Pio::Mac.new('1122.3344.5566') }
        it { expect(subject).to eql Pio::Mac.new('11:22:33:44:55:66') }
        it { expect(subject).to eql '1122.3344.5566' }
        it { expect(subject).to eql '11:22:33:44:55:66' }
        it { expect(subject).not_to eql Pio::Mac.new('6655.4433.2211') }
        it { expect(subject).not_to eql Pio::Mac.new('66:55:44:33:22:11') }
        it { expect(subject).not_to eql '6655.4433.2211' }
        it { expect(subject).not_to eql '66:55:44:33:22:11' }
        it { expect(subject).not_to eql 0x112233445566 }
        it { expect(subject).not_to eql 'INVALID_MAC_ADDRESS' }
      end

      describe '#hash' do
        subject { super().hash }
        it { is_expected.to eq Pio::Mac.new('1122.3344.5566').hash }
        it { is_expected.to eq Pio::Mac.new('11:22:33:44:55:66').hash }
      end

      describe '#to_i' do
        subject { super().to_i }
        it { is_expected.to eq 0x112233445566 }
      end

      describe '#to_a' do
        subject { super().to_a }
        it { is_expected.to eq [0x11, 0x22, 0x33, 0x44, 0x55, 0x66] }
      end

      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq '11:22:33:44:55:66' }
      end

      describe '#to_str' do
        context 'when "MAC = " + subject' do
          it { expect('MAC = ' + subject).to eq 'MAC = 11:22:33:44:55:66' }
        end
      end

      describe '#multicast?' do
        subject { super().multicast? }
        it { is_expected.to be_truthy }
      end

      describe '#broadcast?' do
        subject { super().broadcast? }
        it { is_expected.to be_falsey }
      end

      describe '#reserved?' do
        subject { super().reserved? }
        it { is_expected.to be_falsey }
      end
    end

    context 'with reserved address' do
      (0x0..0xf).each do |each|
        octet = format('%02x', each)
        reserved_address = "01:80:c2:00:00:#{octet}"

        context "when #{reserved_address}" do
          let(:value) { reserved_address }

          describe '#reserved?' do
            subject { super().reserved? }
            it { is_expected.to be_truthy }
          end
        end
      end
    end

    context 'with 0' do
      let(:value) { 0 }

      it { is_expected.to eq Pio::Mac.new(0) }

      describe '#to_i' do
        subject { super().to_i }
        it { is_expected.to eq 0 }
      end

      describe '#to_a' do
        subject { super().to_a }
        it { is_expected.to eq [0x00, 0x00, 0x00, 0x00, 0x00, 0x00] }
      end

      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq '00:00:00:00:00:00' }
      end

      describe '#multicast?' do
        subject { super().multicast? }
        it { is_expected.to be_falsey }
      end

      describe '#broadcast?' do
        subject { super().broadcast? }
        it { is_expected.to be_falsey }
      end

      describe '#reserved?' do
        subject { super().reserved? }
        it { is_expected.to be_falsey }
      end
    end

    context 'with 0xffffffffffff' do
      let(:value) { 0xffffffffffff }

      it { is_expected.to eq Pio::Mac.new(0xffffffffffff) }

      describe '#to_i' do
        subject { super().to_i }
        it { is_expected.to eq 0xffffffffffff }
      end

      describe '#to_a' do
        subject { super().to_a }
        it { is_expected.to eq [0xff, 0xff, 0xff, 0xff, 0xff, 0xff] }
      end

      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq 'ff:ff:ff:ff:ff:ff' }
      end

      describe '#multicast?' do
        subject { super().multicast? }
        it { is_expected.to be_truthy }
      end

      describe '#broadcast?' do
        subject { super().broadcast? }
        it { is_expected.to be_truthy }
      end

      describe '#reserved?' do
        subject { super().reserved? }
        it { is_expected.to be_falsey }
      end
    end

    context 'with "INVALID MAC ADDRESS"' do
      let(:value) { 'INVALID MAC ADDRESS' }

      it { expect { subject }.to raise_error(Pio::Mac::InvalidValueError) }
    end

    context 'with -1' do
      let(:value) { -1 }

      it { expect { subject }.to raise_error(Pio::Mac::InvalidValueError) }
    end

    context 'with 0x1000000000000' do
      let(:value) { 0x1000000000000 }

      it { expect { subject }.to raise_error(Pio::Mac::InvalidValueError) }
    end

    context 'with [ 1, 2, 3 ]' do
      let(:value) { [1, 2, 3] }

      it { expect { subject }.to raise_error(Pio::Mac::InvalidValueError) }
    end
  end
end
