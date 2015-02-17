require 'pio'

describe Pio::OpenFlow do
  Then { Pio::OpenFlow.constants.include?(:HELLO) == true }
end
