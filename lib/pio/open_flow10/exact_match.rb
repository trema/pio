require 'pio/open_flow10/match'

module Pio
  # OpenFlow 1.0 exact match
  class ExactMatch
    def initialize(packet_in)
      @match = packet_in.data.to_exact_match(packet_in.in_port)
    rescue NoMethodError
      raise NotImplementedError,
            "#{packet_in.data.class} is not yet supported by ExactMatch."
    end

    def method_missing(method, *args, &block)
      @match.__send__ method, *args, &block
    end
  end
end
