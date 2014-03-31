require 'pio/echo/request'

module Pio
  # OpenFlow ECHO Request and Reply message parser.
  class Echo
    def self.read(raw_data)
      Echo::Request.read(raw_data)
    end
  end
end
