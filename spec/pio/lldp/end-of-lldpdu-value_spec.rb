require File.join( File.dirname( __FILE__ ), "..", "..", "spec_helper" )
require "pio/lldp/end-of-lldpdu-value"


module Pio
  class Lldp
    describe EndOfLldpduValue do
      subject { EndOfLldpduValue.new }

      its( :tlv_info_string ) { should be_empty }
    end
  end
end


### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
