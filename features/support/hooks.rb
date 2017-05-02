# frozen_string_literal: true

Before('@open_flow10') do
  Pio::OpenFlow.version = :OpenFlow10
end

Before('@open_flow13') do
  Pio::OpenFlow.version = :OpenFlow13
end
