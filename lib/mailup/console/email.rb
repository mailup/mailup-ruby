module MailUp
  module Console
    class Email
      attr_accessor :api

      def initialize(api)
        @api = api
      end

      # Send single email message to specified recipient.
      #
      # @param [Integer] message_id The ID of the message to send.
      # @param [String] email The email address of the recipient.
      #
      # @return [JSON] A Send object with the following attributes:
      #   * idMessage [Integer]
      #   * Sent [Integer]
      #   * UnprocessedRecipients [Array]
      #   * InvalidRecipients [Array]
      #
      # @see http://help.mailup.com/display/mailupapi/Console+methods+v1.1#Consolemethodsv1.1-SendMailMessageToRecipient
      #
      # @example
      #
      #   send = mailup.console.email.send(5, 'joe@public.com')
      #   send['Sent']
      #   => 1
      #
      def send(message_id, email)
        @api.post("#{@api.path}/Email/Send", body: {:idMessage => message_id, :Email => email})
      end

      # Schedules a mailing for immediate sending
      #
      # @param [Integer] Id Sending.
      #
      def send_immediate_confirmation(sending_id)
       @api.post("#{@api.path}/Email/Sendings/#{sending_id}/Immediate")
     end

      # Retrieves the earliest date to schedule the given sending task.
      #
      # @param [Integer] Id Sending.
      #
      def get_deferred_confirmation_date(sending_id)
        @api.get("#{@api.path}/Email/Sendings/#{sending_id}/Deferred")
      end

      # Sets up a mailing for scheduled delivery
      #
      # @param [Integer] Id Sending.
      #
      def send_deferred_confirmation(sending_id)
        @api.post("#{@api.path}/Email/Sendings/#{sending_id}/Deferred")
      end

      # Retrieves the list of email messages that are currently queued up for "immediate sending".
      #
      #
      def get_immediate_confirmation_queque
        @api.get("#{@api.path}/Email/Sendings/Immediate")
      end

      # Retrieves the list of email messages that are currently queued up for "deferred sending".
      #
      #
      def get_deferred_confirmation_queque
        @api.get("#{@api.path}/Email/Sendings/Deferred")
      end

      # Retrieves the list of email messages that are neither "scheduled" nor queued up for "immediate sending".
      #
      #
      def get_undefined_confirmation_queque
        @api.get("#{@api.path}/Email/Sendings/Undefined")
      end
    end
  end
end