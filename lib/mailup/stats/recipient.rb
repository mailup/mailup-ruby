# frozen_string_literal: true

module MailUp
  module Stats
    class Recipient
      attr_accessor :api

      def initialize(id, api)
        @api = api
        @id = id
      end

      # Paged list of messages received by the specified recipient.
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
      # @see http://help.mailup.com/display/mailupapi/Email+statistics+methods+v1.1#Emailstatisticsmethodsv1.1-ListRecipientMessageDeliveries
      #
      # @example
      #
      #   deliveries = mailup.console.recipient(154).deliveries
      #   deliveries['TotalElementsCount']
      #   => 10
      #   deliveries['Items'].first['Subject']
      #   => "Message Subject"
      #
      def deliveries(params = {})
        @api.get("#{@api.path}/Recipient/#{@id}/List/Deliveries", params: params)
      end

      # Count of messages received by the specified recipient.
      #
      #
      # @return [Integer] Count of deliveries.
      #
      # @see http://help.mailup.com/display/mailupapi/Email+statistics+methods+v1.1#Emailstatisticsmethodsv1.1-CountRecipientMessageDeliveries
      #
      # @example
      #
      #   deliveries = mailup.console.recipient(154).deliveries_count
      #   => 324
      #
      def deliveries_count
        @api.get("#{@api.path}/Recipient/#{@id}/Count/Deliveries")
      end

      # Paged list of messages viewed by the specified recipient.
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
      # @see http://help.mailup.com/display/mailupapi/Email+statistics+methods+v1.1#Emailstatisticsmethodsv1.1-ListRecipientMessageViews
      #
      # @example
      #
      #   views = mailup.console.recipient(154).views
      #   views['TotalElementsCount']
      #   => 10
      #   views['Items'].first['Subject']
      #   => "Message Subject"
      #
      def views(params = {})
        @api.get("#{@api.path}/Recipient/#{@id}/List/Views", params: params)
      end

      # Count of messages viewed by the specified recipient.
      #
      #
      # @return [Integer] Count of views.
      #
      # @see http://help.mailup.com/display/mailupapi/Email+statistics+methods+v1.1#Emailstatisticsmethodsv1.1-CountRecipientMessageViews
      #
      # @example
      #
      #   views = mailup.console.recipient(154).views_count
      #   => 324
      #
      def views_count
        @api.get("#{@api.path}/Recipient/#{@id}/Count/Views")
      end

      # Paged list of bounces with details returned by the specified recipient.
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
      # @see http://help.mailup.com/display/mailupapi/Email+statistics+methods+v1.1#Emailstatisticsmethodsv1.1-ListRecipientMessageBouncesDetails
      #
      # @example
      #
      #   bounces = mailup.console.recipient(154).bounces_details
      #   bounces['TotalElementsCount']
      #   => 10
      #   bounces['Items'].first['Subject']
      #   => "Message Subject"
      #
      def bounces_details(params = {})
        @api.get("#{@api.path}/Recipient/#{@id}/List/BouncesDetails", params: params)
      end

      # Paged list of bounces returned by the specified recipient.
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
      # @see http://help.mailup.com/display/mailupapi/Email+statistics+methods+v1.1#Emailstatisticsmethodsv1.1-ListRecipientMessageBounces
      #
      # @example
      #
      #   bounces = mailup.console.recipient(154).bounces
      #   bounces['TotalElementsCount']
      #   => 10
      #   bounces['Items'].first['Subject']
      #   => "Message Subject"
      #
      def bounces(params = {})
        @api.get("#{@api.path}/Recipient/#{@id}/List/Bounces", params: params)
      end

      # Count of bounces returned by the specified recipient.
      #
      #
      # @return [Integer] Count of bounces.
      #
      # @see http://help.mailup.com/display/mailupapi/Email+statistics+methods+v1.1#Emailstatisticsmethodsv1.1-CountRecipientMessageBounces
      #
      # @example
      #
      #   views = mailup.console.recipient(154).bounces_count
      #   => 324
      #
      def bounces_count
        @api.get("#{@api.path}/Recipient/#{@id}/Count/Bounces")
      end

      # Paged list of unsubscriptions done by the specified recipient.
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
      # @see http://help.mailup.com/display/mailupapi/Email+statistics+methods+v1.1#Emailstatisticsmethodsv1.1-ListRecipientUnsubscriptions
      #
      # @example
      #
      #   unsubscribes = mailup.console.recipient(154).unsubscribes
      #   unsubscribes['TotalElementsCount']
      #   => 10
      #   unsubscribes['Items'].first['Subject']
      #   => "Message Subject"
      #
      def unsubscribes(params = {})
        @api.get("#{@api.path}/Recipient/#{@id}/List/Unsubscriptions", params: params)
      end

      # Count of unsubscriptions done by the specified recipient.
      #
      #
      # @return [Integer] Count of unsubscribes.
      #
      # @see http://help.mailup.com/display/mailupapi/Email+statistics+methods+v1.1#Emailstatisticsmethodsv1.1-CountRecipientUnsubscriptions
      #
      # @example
      #
      #   unsubscribes = mailup.console.recipient(154).unsubscribes_count
      #   => 324
      #
      def unsubscribes_count
        @api.get("#{@api.path}/Recipient/#{@id}/Count/Unsubscriptions")
      end

      # Verbose paged list of message clicks on a link done by the specified recipient.
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
      # @see http://help.mailup.com/display/mailupapi/Email+statistics+methods#Emailstatisticsmethods-ListRecipientClickDetailsByDate
      #
      # @example
      #
      #   clicks = mailup.console.recipient(154).clicks_details
      #   clicks['TotalElementsCount']
      #   => 10
      #   clicks['Items'].first['Subject']
      #   => "Message Subject"
      #
      def clicks_details(params = {})
        @api.get("#{@api.path}/Recipient/#{@id}/List/ClicksDetails", params: params)
      end

      # Paged list of message clicks on a link done by the specified recipient.
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
      # @see http://help.mailup.com/display/mailupapi/Email+statistics+methods+v1.1#Emailstatisticsmethodsv1.1-ListRecipientMessageClicks
      #
      # @example
      #
      #   clicks = mailup.console.recipient(154).clicks
      #   clicks['TotalElementsCount']
      #   => 10
      #   clicks['Items'].first['Subject']
      #   => "Message Subject"
      #
      def clicks(params = {})
        @api.get("#{@api.path}/Recipient/#{@id}/List/Clicks", params: params)
      end

      # Count of clicks on a link in the specified email.
      #
      #
      # @return [Integer] Count of clicks.
      #
      # @see http://help.mailup.com/display/mailupapi/Email+statistics+methods+v1.1#Emailstatisticsmethodsv1.1-CountRecipientClicks
      #
      # @example
      #
      #   clicks = mailup.console.recipient(154).clicks_count
      #   => 324
      #
      def clicks_count
        @api.get("#{@api.path}/Recipient/#{@id}/Count/Clicks")
      end
    end
  end
end
