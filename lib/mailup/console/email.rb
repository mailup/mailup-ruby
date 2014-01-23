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

    end
  end
end