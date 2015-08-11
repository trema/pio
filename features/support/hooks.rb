Before('@open_flow10') do
  Pio::OpenFlow.switch_version :OpenFlow10
end

Before('@open_flow13') do
  Pio::OpenFlow.switch_version :OpenFlow13
end
