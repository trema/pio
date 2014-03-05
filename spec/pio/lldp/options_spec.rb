# -*- coding: utf-8 -*-
require 'pio'

describe Pio::Lldp::Options do
  context '.new' do
    subject { Pio::Lldp::Options.new(options).to_hash }

    context 'with :dpid and :port_number' do
      let(:options) do
        {
         dpid: 0x192fa7b28d,
         port_number: 1
        }
      end

      its([:chassis_id]) { should eq 0x192fa7b28d }
      its([:port_id]) { should eq 1 }
      its([:destination_mac]) { should eq Pio::Mac.new('01:80:c2:00:00:0e') }
      its([:source_mac]) { should eq Pio::Mac.new('01:02:03:04:05:06') }
    end

    context 'with :dpid and :port_number and :UNKNOWN_OPTION' do
      let(:options) do
        {
          dpid: 0x192fa7b28d,
          port_number: 1,
          UNKNOWN_OPTION: :foo
        }
      end

      it do
        expect do
          subject
        end.to raise_error('Unknown option: UNKNOWN_OPTION.')
      end
    end

    context 'with :dpid, :port_number and :destination_mac' do
      let(:options) do
        {
         dpid: 0x192fa7b28d,
         port_number: 1,
         destination_mac: '06:05:04:03:02:01'
        }
      end

      its([:chassis_id]) { should eq 0x192fa7b28d }
      its([:port_id]) { should eq 1 }
      its([:destination_mac]) { should eq Pio::Mac.new('06:05:04:03:02:01') }
      its([:source_mac]) { should eq Pio::Mac.new('01:02:03:04:05:06') }
    end

    context 'with :dpid, :port_number and :source_mac' do
      let(:options) do
        {
         dpid: 0x192fa7b28d,
         port_number: 1,
         source_mac: '06:05:04:03:02:01'
        }
      end

      its([:chassis_id]) { should eq 0x192fa7b28d }
      its([:port_id]) { should eq 1 }
      its([:destination_mac]) { should eq Pio::Mac.new('01:80:c2:00:00:0e') }
      its([:source_mac]) { should eq Pio::Mac.new('06:05:04:03:02:01') }
    end

    context 'with :dpid, :port_number and :destination_mac(=nil)' do
      let(:options) do
        {
         dpid: 0x192fa7b28d,
         port_number: 1,
         destination_mac: nil
        }
      end

      its([:chassis_id]) { should eq 0x192fa7b28d }
      its([:port_id]) { should eq 1 }
      its([:destination_mac]) { should eq Pio::Mac.new('01:80:c2:00:00:0e') }
      its([:source_mac]) { should eq Pio::Mac.new('01:02:03:04:05:06') }
    end

    context 'with :dpid, :port_number,'\
            ' :destination_mac(=nil) and :source_mac(=nil)' do
      let(:options) do
        {
         dpid: 0x192fa7b28d,
         port_number: 1,
         destination_mac: nil,
         source_mac: nil
        }
      end

      its([:chassis_id]) { should eq 0x192fa7b28d }
      its([:port_id]) { should eq 1 }
      its([:destination_mac]) { should eq Pio::Mac.new('01:80:c2:00:00:0e') }
      its([:source_mac]) { should eq Pio::Mac.new('01:02:03:04:05:06') }
    end

    context 'when :dpid is not passed' do
      let(:options) { { port_number: 1 } }

      it do
        expect { subject }.to raise_error('The dpid option should be passed.')
      end
    end

    context 'when :dpid is nil' do
      let(:options) { { dpid: nil, port_number: 1 } }

      it do
        expect { subject }.to raise_error("The dpid option shouldn't be nil.")
      end
    end

    context 'when :port_number is not passed' do
      let(:options) { { dpid: 0x192fa7b28d } }

      it do
        expect do
          subject
        end.to raise_error('The port_number option should be passed.')
      end
    end

    context 'when :port_number is nil' do
      let(:options) { { dpid: 1, port_number: nil } }

      it do
        expect do
          subject
        end.to raise_error("The port_number option shouldn't be nil.")
      end
    end
  end
end

### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
