# frozen_string_literal: true

module MailUp
  module Console
    class Import
      attr_accessor :api

      def initialize(id, api)
        @api = api
        @id = id
      end

      # Get import status.
      #
      # @return [JSON] A Status object with the following attributes:
      #   * idImport [Integer]
      #   * Completed [Boolean]
      #   * UpdatedRecipients [Integer]
      #   * ValidRecipients [Integer]
      #   * CreatedRecipients [Integer]
      #   * ImportedRecipients [Integer]
      #   * NotValidRecipients [Integer]
      #
      # @see http://help.mailup.com/display/mailupapi/Console+methods+v1.1#Consolemethodsv1.1-GetImportStatus
      #
      # @example
      #
      #   status = mailup.console.import(9).status
      #   status['Completed']
      #   => true
      #   status['UpdatedRecipients']
      #   => 159
      #
      def status
        @api.get("#{@api.path}/Import/#{@id}")
      end

      # Get Sending Confirmation Email Id.
      #
      # @see http://help.mailup.com/display/mailupapi/Recipients#Recipients-SendConfirmationEmail
      #
      def confirmation_email_id
        @api.get("#{@api.path}/Import/#{@id}/Sending")
      end
    end
  end
end
