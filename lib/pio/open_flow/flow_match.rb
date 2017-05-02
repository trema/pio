# frozen_string_literal: true

require 'active_support/descendants_tracker'

module Pio
  module OpenFlow
    # Flow match
    class FlowMatch
      extend ActiveSupport::DescendantsTracker
    end
  end
end
