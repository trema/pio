# -*- coding: utf-8 -*-
module Pio
  # Pio Read Util.
  module Util
    def read(raw_data)
      begin
        frame = const_get('Frame').read(raw_data)
      rescue
        raise Pio::ParseError, $ERROR_INFO.message
      end

      const_get('MESSAGE_TYPE')[frame.message_type].create_from frame
    end
  end
end
### Local variables:
### mode: Ruby
### coding: utf-8
### indent-tabs-mode: nil
### End:
