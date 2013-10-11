require "pio/mac"


module Pio
  describe Mac do
    context ".new" do
      subject { Mac.new( value ) }


      context %{with "11:22:33:44:55:66"} do
        let( :value ) { "11:22:33:44:55:66" }

        describe "#==" do
          it { should == Mac.new( "11:22:33:44:55:66" ) }
          it { should_not == Mac.new( "66:55:44:33:22:11" ) }
          it { should == "11:22:33:44:55:66" }
          it { should_not == "66:55:44:33:22:11" }
          it { should_not == "INVALID_MAC_ADDRESS" }
          it { should == 0x112233445566 }
          it { should_not == 42 }
        end

        its( :to_int ) { should eq 0x112233445566 }
        its( :to_str ) { should eq "11:22:33:44:55:66" }
        its( :to_ary ) { should eq [ 0x11, 0x22, 0x33, 0x44, 0x55, 0x66 ] }
        its( :multicast? ){ should be_true }
        its( :broadcast? ){ should be_false }
      end


      context "with 0" do
        let( :value ) { 0 }
        it { should eq Mac.new( 0 ) }
        its( :to_int ) { should eq 0 }
        its( :to_str ) { should eq "00:00:00:00:00:00" }
        its( :to_ary ) { should eq [ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 ] }
        its( :multicast? ){ should be_false }
        its( :broadcast? ){ should be_false }
      end


      context "with 0xffffffffffff" do
        let( :value ) { 0xffffffffffff }
        it { should eq Mac.new( 0xffffffffffff ) }
        its( :to_int ) { should eq 0xffffffffffff }
        its( :to_str ) { should eq "ff:ff:ff:ff:ff:ff" }
        its( :to_ary ) { should eq [ 0xff, 0xff, 0xff, 0xff, 0xff, 0xff ] }
        its( :multicast? ){ should be_true }
        its( :broadcast? ){ should be_true }
      end


      context %{with "INVALID MAC ADDRESS"} do
        let( :value ) { "INVALID MAC ADDRESS" }
        it { expect { subject }.to raise_error( ArgumentError ) }
      end


      context "with -1" do
        let( :value ) { -1 }
        it { expect { subject }.to raise_error( ArgumentError ) }
      end


      context "with 0x1000000000000" do
        let( :value ) { 0x1000000000000 }
        it { expect { subject }.to raise_error( ArgumentError ) }
      end


      context "with [ 1, 2, 3 ]" do
        let( :value ) { [ 1, 2, 3 ] }
        it { expect { subject }.to raise_error( TypeError ) }
      end


      context %{with "00:00:00:00:00:01"} do
        let( :value ) { "00:00:00:00:00:01" }
        it { expect( subject ).to eql Mac.new( "00:00:00:00:00:01" ) }
        its( :hash ) { should eq Mac.new( "00:00:00:00:00:01" ).hash }
      end
    end
  end
end


### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
