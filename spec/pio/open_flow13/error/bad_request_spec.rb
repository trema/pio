require 'pio/open_flow13/error/bad_request'

describe Pio::OpenFlow13::Error::BadRequest do
  it_should_behave_like('an OpenFlow message',
                        Pio::OpenFlow13::Error::BadRequest)
end
