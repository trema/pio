# frozen_string_literal: true

require 'active_support/descendants_tracker'

module Pio
  module OpenFlow
    # Flow instruction
    class Instruction
      extend ActiveSupport::DescendantsTracker
    end
  end
end
