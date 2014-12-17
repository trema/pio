require 'pio'

describe Pio::OpenFlow::Type do
  Then { Pio::OpenFlow::Type.constants.include?(:HELLO) == true }
end
