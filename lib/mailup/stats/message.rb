module MailUp
  module Stats
    class Message
      attr_accessor :api

      def initialize(id, api)
          @api = api
          @id = id
      end

      # Paged list of recipients who received the specified email.
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
      # @see http://help.mailup.com/display/mailupapi/Email+statistics+methods+v1.1#Emailstatisticsmethodsv1.1-ListMessageRecipients
      #
      # @example
      #
      #   recipients = mailup.stats.message(9).recipients
      #   recipients['TotalElementsCount']
      #   => 10
      #   recipients['Items'].first['Email']
      #   => "joe@public.com"
      #
      def recipients(params = {})
        @api.get("#{@api.path}/Message/#{@id}/List/Recipients", params: params)
      end
      
      # Count of recipients who received the specified email.
      #
      #
      # @return [Integer] Count of recipients.
      #
      # @see http://help.mailup.com/display/mailupapi/Email+statistics+methods+v1.1#Emailstatisticsmethodsv1.1-CountMessageRecipients
      #
      # @example
      #
      #   recipients = mailup.stats.message(9).recipients_count
      #   => 10
      #
      def recipients_count
        @api.get("#{@api.path}/Message/#{@id}/Count/Recipients")
      end
      alias_method :received_count, :recipients_count
      
      # Paged list of views of the specified email.
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
      # @see http://help.mailup.com/display/mailupapi/Email+statistics+methods+v1.1#Emailstatisticsmethodsv1.1-ListMessageViews
      #
      # @example
      #
      #   views = mailup.stats.message(9).views
      #   views['TotalElementsCount']
      #   => 10
      #
      def views(params = {})
        @api.get("#{@api.path}/Message/#{@id}/List/Views", params: params)
      end
      
      # Count of views of the specified email.
      #
      #
      # @return [Integer] Count of views.
      #
      # @see http://help.mailup.com/display/mailupapi/Email+statistics+methods+v1.1#Emailstatisticsmethodsv1.1-CountMessageViews
      #
      # @example
      #
      #   views = mailup.stats.message(9).views_count
      #   => 3453
      #
      def views_count
        @api.get("#{@api.path}/Message/#{@id}/Count/Views")
      end
      
      # Paged list of bounces from the specified email.
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
      # @see http://help.mailup.com/display/mailupapi/Email+statistics+methods+v1.1#Emailstatisticsmethodsv1.1-ListMessageBounces
      #
      # @example
      #
      #   bounces = mailup.stats.message(9).bounces
      #   bounces['TotalElementsCount']
      #   => 10
      #
      def bounces(params = {})
        @api.get("#{@api.path}/Message/#{@id}/List/Bounces", params: params)
      end
      
      # Count of bounces from the specified mail.
      #
      #
      # @return [Integer] Count of bounces.
      #
      # @see http://help.mailup.com/display/mailupapi/Email+statistics+methods+v1.1#Emailstatisticsmethodsv1.1-CountMessageBounces
      #
      # @example
      #
      #   bounces = mailup.stats.message(9).bounces_count
      #   => 3453
      #
      def bounces_count
        @api.get("#{@api.path}/Message/#{@id}/Count/Bounces")
      end
      
      # Paged list of unsubscriptions from the specified email.
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
      # @see http://help.mailup.com/display/mailupapi/Email+statistics+methods+v1.1#Emailstatisticsmethodsv1.1-ListMessageUnsubscriptions
      #
      # @example
      #
      #   unsubs = mailup.stats.message(9).unsubscribes
      #   unsubs['TotalElementsCount']
      #   => 10
      #
      def unsubscribes(params = {})
        @api.get("#{@api.path}/Message/#{@id}/List/Unsubscriptions", params: params)
      end
      
      # Count of unsubscriptions from the specified email.
      #
      #
      # @return [Integer] Count of unsubscribes.
      #
      # @see http://help.mailup.com/display/mailupapi/Email+statistics+methods+v1.1#Emailstatisticsmethodsv1.1-CountMessageUnsubscriptions
      #
      # @example
      #
      #   unsubs = mailup.stats.message(9).unsubscribes_count
      #   => 234
      #
      def unsubscribes_count
        @api.get("#{@api.path}/Message/#{@id}/Count/Unsubscriptions")
      end
      
      # Paged list of clicks on a link in the specified email.
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
      # @see http://help.mailup.com/display/mailupapi/Email+statistics+methods+v1.1#Emailstatisticsmethodsv1.1-ListMessageClicks
      #
      # @example
      #
      #   clicks = mailup.stats.message(9).clicks
      #   clicks['TotalElementsCount']
      #   => 10
      #   clicks['Items'].first['Count']
      #   => 3
      #
      def clicks(params = {})
        @api.get("#{@api.path}/Message/#{@id}/List/Clicks", params: params)
      end
      
      # Count of clicks on a link in the specified email.
      #
      #
      # @return [Integer] Count of bounces.
      #
      # @see http://help.mailup.com/display/mailupapi/Email+statistics+methods+v1.1#Emailstatisticsmethodsv1.1-CountMessageClicks
      #
      # @example
      #
      #   clicks = mailup.stats.message(9).clicks_count
      #   => 3453
      #
      def clicks_count
        @api.get("#{@api.path}/Message/#{@id}/Count/Clicks")
      end

      # Paged list of clicks on a link in the specified email.
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
      # @see http://help.mailup.com/display/mailupapi/Email+statistics+methods+v1.1#Emailstatisticsmethodsv1.1-ListMessageUrlClicks
      #
      # @example
      #
      #   url_clicks = mailup.stats.message(9).url_clicks
      #   url_clicks['TotalElementsCount']
      #   => 10
      #   url_clicks['Items'].first['Count']
      #   => 3
      #
      def url_clicks(params = {})
        @api.get("#{@api.path}/Message/#{@id}/List/UrlClicks", params: params)
      end
      
      # Count of clicks on a link in the specified email.
      #
      #
      # @return [Integer] Count of bounces.
      #
      # @see http://help.mailup.com/display/mailupapi/Email+statistics+methods+v1.1#Emailstatisticsmethodsv1.1-CountMessageClicks
      #
      # @example
      #
      #   url_clicks = mailup.stats.message(9).url_clicks_count
      #   => 3453
      #
      def url_clicks_count
        @api.get("#{@api.path}/Message/#{@id}/Count/UrlClicks")
      end

    end
  end
end