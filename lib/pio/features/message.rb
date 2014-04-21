# encoding: utf-8

module Pio
  class Features
    # Base class of Features request and reply.
    class Message
      def self.create_from(features)
        message = allocate
        message.instance_variable_set :@features, features
        message
      end
    end
  end
end
