require 'pio/open_flow10'
require 'pio/open_flow13'

module Pio
  module OpenFlow
    # Collection class of OpenFlow message parser class
    class Parser
      def self.find_by_type!(type)
        message_class = [Hello, Error, Echo::Request, Echo::Reply,
                         Features::Request, Features::Reply, PacketIn,
                         PacketOut, FlowMod, PortStatus, Stats::Request,
                         Stats::Reply, Barrier::Request, Barrier::Reply]
        message_class.each_with_object({}) do |each, hash|
          hash[each.type] = each
        end.fetch(type)
      end
    end
  end
end
