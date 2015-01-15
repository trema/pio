require 'pio'

echo = Pio::Echo::Request.read(binary_data)
echo.xid # => 123
