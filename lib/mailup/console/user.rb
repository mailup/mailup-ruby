# frozen_string_literal: true

module MailUp
  module Console
    class User
      attr_accessor :api

      def initialize(api)
        @api = api
      end

      # Retrieve the admin console lists for the current user.
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
      # @see http://help.mailup.com/display/mailupapi/Console+methods+v1.1#Consolemethodsv1.1-GetConsoleListsByUser
      #
      # @example
      #
      #   lists = mailup.console.user.lists
      #   lists = mailup.console.user.lists
      #   lists['TotalElementsCount']
      #   => 10
      #   lists['Items'].first['Name']
      #   => "Test List"
      #
      #   lists = mailup.console.user.lists(pageNumber: 0, pageSize: 250)
      #
      def lists(params = {})
        @api.get("#{@api.path}/User/Lists", params: params)
      end

      # Retrieve the email messages (cloned and not cloned) for the current user.
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
      # @see http://help.mailup.com/display/mailupapi/Console+methods+v1.1#Consolemethodsv1.1-GetMailMessagesByUser
      #
      # @example
      #
      #   emails = mailup.console.user.emails
      #   emails['TotalElementsCount']
      #   => 10
      #   emails['Items'].first['Subject']
      #   => "Test Subject"
      #
      #   emails = mailup.console.user.emails(pageNumber: 0, pageSize: 1)
      #
      def emails(params = {})
        @api.get("#{@api.path}/User/Emails", params: params)
      end
    end
  end
end
