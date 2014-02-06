module MailUp
  module Console
    class Recipient
      attr_accessor :api

      def initialize(api)
          @api = api
      end

      # Update a recipient with the specified details into address book.
      # 
      # @param [Hash] recipient A hash of recipient attributes:
      # @option recipient [String] :Name of the recipient (required).
      # @option recipient [String] :Email of the recipient (required).
      # @option recipient [String] :MobilePrefix of the recipient.
      # @option recipient [String] :MobileNumber of the recipient.
      # @option recipient [Array] :Fields to include.
      #
      # @return [JSON] The updated Recipient object with the following attributes:
      #   * idRecipient [Integer]
      #   * Name [String]
      #   * Email [String]
      #   * MobilePrefix [String]
      #   * MobileNumber [String]
      #   * Fields [Array]
      #
      # @see http://help.mailup.com/display/mailupapi/Console+methods+v1.1#Consolemethodsv1.1-UpdateRecipientDetail
      # 
      # @example
      #
      #   recipient = {
      #     :Name => "Joe Public",
      #     :Email => "joe@public.com"
      #   }
      #   updated_recipient = mailup.console.recipient.update(recipient)
      #   updated_recipient['Name']
      #   => "Joe Public"
      #
      def update(recipient)
        @api.put("#{@api.path}/Recipient/Detail", body: recipient)
      end
      
      # Retrieve recipient dynamic field definitions.
      # 
      # @return [JSON] Results and data including:
      #   * IsPaginated [Boolean]
      #   * Items [Array<Hash>]
      #   * PageNumber [Integer]
      #   * PageSize [Integer]
      #   * Skipped [Integer]
      #   * TotalElementsCount [Integer]
      #
      # @see http://help.mailup.com/display/mailupapi/Console+methods+v1.1#Consolemethodsv1.1-GetDynamicFields
      # 
      # @example
      #
      #   fields = mailup.console.recipient.fields
      #   fields.size
      #   => 10
      #   fields['Items'].first['Description']
      #   => "Field description..."
      #
      def fields
        @api.get("#{@api.path}/Recipient/DynamicFields")
      end
      
    end
  end
end