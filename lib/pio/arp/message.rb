require "forwardable"
require "pio/arp/frame"
require "pio/ipv4_address"


module Pio
  class Arp
    # Base class of ARP Request and Reply
    class Message
      extend Forwardable


      def self.create_from frame
        message = allocate
        message.instance_variable_set :@frame, frame
        message
      end


      def initialize options
        @options = options
        @frame = Arp::Frame.new( option_hash )
      end


      def_delegators :@frame, :destination_mac
      def_delegators :@frame, :source_mac
      def_delegators :@frame, :ether_type
      def_delegators :@frame, :hardware_type
      def_delegators :@frame, :protocol_type
      def_delegators :@frame, :hardware_length
      def_delegators :@frame, :protocol_length
      def_delegators :@frame, :operation
      def_delegators :@frame, :sender_hardware_address
      def_delegators :@frame, :sender_protocol_address
      def_delegators :@frame, :target_hardware_address
      def_delegators :@frame, :target_protocol_address
      def_delegators :@frame, :to_binary


      ##########################################################################
      private
      ##########################################################################


      def option_hash
        mandatory_options.inject( {} ) do | opt, each |
          klass = option_to_klass[ each ]
          opt_pair = { each => klass.new( user_options[ each ] ).to_a }
          opt.merge opt_pair
        end.merge default_options
      end


      def option_to_klass
        {
          :source_mac => Mac,
          :destination_mac => Mac,
          :sender_hardware_address => Mac,
          :target_hardware_address => Mac,
          :sender_protocol_address => IPv4Address,
          :target_protocol_address => IPv4Address,
        }
      end
    end
  end
end
