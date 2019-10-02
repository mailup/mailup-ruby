# frozen_string_literal: true

module MailUp
  module Stats
    class Base
      attr_accessor :api

      def initialize(api) # :nodoc:
        @api = api
        @api.path = "/API/v#{MailUp::API_VERSION}/Rest/MailStatisticsService.svc"
      end

      # Create a message object
      #
      # @param [Integer] id The message_id of the message to access.
      #
      # @return [MailUp::Stats::Message]
      #
      # @example
      #
      #   message = mailup.stats.message(1)
      #
      def message(id)
        Message.new id, @api
      end

      # Create a recipient object
      #
      # @param [Integer] id The recipient_id of the recipient to access.
      #
      # @return [MailUp::Stats::Recipient]
      #
      # @example
      #
      #   recipient = mailup.stats.recipient(154)
      #
      def recipient(id)
        Recipient.new id, @api
      end
    end
  end
end
