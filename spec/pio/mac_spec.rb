require "pio/mac"


module Pio
  describe Mac do
    context ".new" do
      subject { Mac.new( value ) }


      context %{with "11:22:33:44:55:66"} do
        let( :value ) { "11:22:33:44:55:66" }

        describe "#==" do
          it { should eq Mac.new( "11:22:33:44:55:66" ) }
          it { should eq "11:22:33:44:55:66" }
          it { should_not eq Mac.new( "66:55:44:33:22:11" ) }
          it { should_not eq "66:55:44:33:22:11" }
          it { should eq 0x112233445566 }
          it { should_not eq 42 }
          it { should_not eq "INVALID_MAC_ADDRESS" }
        end
        describe "#eql?" do
          it { expect( subject ).to eql Mac.new( "11:22:33:44:55:66" ) }
          it { expect( subject ).to eql "11:22:33:44:55:66" }
          it { expect( subject ).not_to eql Mac.new( "66:55:44:33:22:11" ) }
          it { expect( subject ).not_to eql "66:55:44:33:22:11" }
          it { expect( subject ).to eql 0x112233445566 }
          it { expect( subject ).not_to eql 42 }
          it { expect( subject ).not_to eql "INVALID_MAC_ADDRESS" }
        end

        its( :hash ) { should eq Mac.new( "11:22:33:44:55:66" ).hash }

        its( :to_i ) { should eq 0x112233445566 }
        its( :to_a ) { should eq [ 0x11, 0x22, 0x33, 0x44, 0x55, 0x66 ] }
        its( :to_s ) { should eq "11:22:33:44:55:66" }
        describe "#to_str" do
          context %{when "MAC = " + subject} do
            it { expect( "MAC = " + subject ).to eq "MAC = 11:22:33:44:55:66" }
          end
        end

        its( :multicast? ){ should be_true }
        its( :broadcast? ){ should be_false }
        its( :reserved? ){ should be_false }
      end


      context "with reserved address" do
        ( 0x0..0xf ).each do | each |
          octet = "%02x" % each
          reserved_address = "01:80:c2:00:00:#{ octet }"

          context "when #{ reserved_address }" do
            let( :value ) { reserved_address }
            its( :reserved? ) { should be_true }
          end
        end
      end


      context "with 0" do
        let( :value ) { 0 }

        it { should eq Mac.new( 0 ) }
        its( :to_i ) { should eq 0 }
        its( :to_a ) { should eq [ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 ] }
        its( :to_s ) { should eq "00:00:00:00:00:00" }
        its( :multicast? ){ should be_false }
        its( :broadcast? ){ should be_false }
        its( :reserved? ){ should be_false }
      end


      context "with 0xffffffffffff" do
        let( :value ) { 0xffffffffffff }

        it { should eq Mac.new( 0xffffffffffff ) }
        its( :to_i ) { should eq 0xffffffffffff }
        its( :to_a ) { should eq [ 0xff, 0xff, 0xff, 0xff, 0xff, 0xff ] }
        its( :to_s ) { should eq "ff:ff:ff:ff:ff:ff" }
        its( :multicast? ){ should be_true }
        its( :broadcast? ){ should be_true }
        its( :reserved? ){ should be_false }
      end


      context %{with "INVALID MAC ADDRESS"} do
        let( :value ) { "INVALID MAC ADDRESS" }

        it { expect { subject }.to raise_error( Mac::InvalidValueError ) }
      end


      context "with -1" do
        let( :value ) { -1 }

        it { expect { subject }.to raise_error( Mac::InvalidValueError ) }
      end


      context "with 0x1000000000000" do
        let( :value ) { 0x1000000000000 }

        it { expect { subject }.to raise_error( Mac::InvalidValueError ) }
      end


      context "with [ 1, 2, 3 ]" do
        let( :value ) { [ 1, 2, 3 ] }

        it { expect { subject }.to raise_error( Mac::InvalidValueError ) }
      end
    end
  end
end


### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
