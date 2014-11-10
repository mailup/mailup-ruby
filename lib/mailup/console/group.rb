module MailUp
  module Console
    class Group
      attr_accessor :api

      def initialize(id, api)
        @api = api
        @id = id
      end

      # Async Import recipients to the specified group.
      #
      # @param [Array] recipients an array ConsoleRecipientItems (See http://help.mailup.com/display/mailupapi/Models+v1.1#Modelsv1.1-ConsoleRecipientItem).
      # @param [Hash] params Optional params or filters:
      # @option params [Boolean] :ConfirmEmail Confirmed opt-in option. Default false.
      #
      # @see http://help.mailup.com/display/mailupapi/Console+methods+v1.1#Consolemethodsv1.1-AsyncImportRecipientsToGroup
      #
      def add_recipients(recipients, params = {})
        @api.post("#{@api.path}/Group/#{@id}/Recipients", body: recipients, params: params)
      end

      # Retrieve the recipients in the specified group.
      #
      # @param [Hash] params Optional params or filters:
      # @option params [Integer] :pageNumber The page number to return.
      # @option params [Integer] :pageSize The number of results to per page.
      # @option params [String] :filterby A filtering expression.
      # @option params [String] :orderby The sorting condition for the results.
      #
      # @return [JSON] Results and data including:
      #   * IsPaginated [Boolean]
      #   * Items [Array<Hash>]
      #   * PageNumber [Integer]
      #   * PageSize [Integer]
      #   * Skipped [Integer]
      #   * TotalElementsCount [Integer]
      #
      # @see http://help.mailup.com/display/mailupapi/Console+methods+v1.1#Consolemethodsv1.1-GetRecipientsByGroup
      #
      # @example
      #
      #   recipients = mailup.console.group(5).recipients
      #   recipients['TotalElementsCount']
      #   => 125
      #   recipients['Items'].first['Name']
      #   => "Joe Public"
      #
      def recipients(params = {})
        @api.get("#{@api.path}/Group/#{@id}/Recipients", params: params)
      end

      # Subscribe the recipient with the related id to the specified group.
      #
      # @param [Integer] recipient_id The ID of the recipient.
      #
      # @return [Boolean] `true` if successful.
      #
      # @see http://help.mailup.com/display/mailupapi/Console+methods+v1.1#Consolemethodsv1.1-SubscribeRecipientToGroup
      #
      # @example
      #
      #   susbcribe = mailup.console.group(5).subscribe(126)
      #   => true
      #
      def subscribe(recipient_id)
        @api.post("#{@api.path}/Group/#{@id}/Subscribe/#{recipient_id}")
      end

      # Unsubscribe the recipient with the related id from the specified group.
      #
      # @param [Integer] recipient_id The ID of the recipient.
      #
      # @return [Boolean] `true` if successful.
      #
      # @see http://help.mailup.com/display/mailupapi/Console+methods+v1.1#Consolemethodsv1.1-UnsubscribeRecipientFromGroup
      #
      # @example
      #
      #   unsusbcribe = mailup.console.group(5).unsubscribe(126)
      #   => true
      #
      def unsubscribe(recipient_id)
        @api.delete("#{@api.path}/Group/#{@id}/Unsubscribe/#{recipient_id}")
      end

      # Send email message to all recipient in group.
      #
      # @param [Integer] message_id of the message.
      #
      # @return [JSON] A Send object with the following attributes:
      #   * idMessage [Integer]
      #   * Sent [Integer]
      #   * UnprocessedRecipients [Array]
      #   * InvalidRecipients [Array]
      #
      # @see http://help.mailup.com/display/mailupapi/Console+methods+v1.1#Consolemethodsv1.1-SendMailMessageToRecipientInGroup
      #
      # @example
      #
      #   send = mailup.console.group(5).send_message(1340)
      #   send['Sent']
      #   => 1794
      #
      def send_message(message_id)
        @api.post("#{@api.path}/Group/#{@id}/Email/#{message_id}/Send")
      end

    end
  end
end