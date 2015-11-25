require 'active_support/descendants_tracker'

module Pio
  module OpenFlow
    # OpenFlow matches.
    class Match
      extend ActiveSupport::DescendantsTracker
    end
  end
end
