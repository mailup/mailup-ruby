module MailUp
  module Console
    class Base
      attr_accessor :api

      def initialize(api) # :nodoc:
          @api = api
          @api.path = "/API/v#{MailUp::API_VERSION}/Rest/ConsoleService.svc/Console"
      end

      # Create an email object
      #
      # @return [MailUp::Console::Email] 
      #
      # @example
      #
      #   email = mailup.console.email
      #
      def email
        Email.new @api
      end

      # Create a group object
      # 
      # @param [Integer] id The group_id of the group to access.
      #
      # @return [MailUp::Console::Group] 
      #
      # @example
      #
      #   group = mailup.console.group(1)
      #
      def group(id)
        Group.new id, @api
      end

      # Create an images object
      #
      # @return [MailUp::Console::Images] 
      #
      # @example
      #
      #   images = mailup.console.images
      #
      def images
        Images.new @api
      end
      
      # Create an import object
      # 
      # @param [Integer] idImport The ID of the import process.
      #
      # @return [MailUp::Console::Import] 
      #
      # @example
      #
      #   import = mailup.console.import(9)
      #
      def import(id)
        Import.new id, @api
      end

      # Create a list object
      # 
      # @param [Integer] id The list_id of the list to access.
      #
      # @return [MailUp::Console::List] 
      #
      # @example
      #
      #   list = mailup.console.list(2)
      #
      def list(id)
        List.new id, @api
      end

      # Create a public methods object
      #
      # @return [MailUp::Console::List] 
      #
      # @example
      #
      #   list = mailup.console.list(2)
      #
      def public
        Public::Base.new @api
      end

      # Create a recipient object
      #
      # @return [MailUp::Console::Recipient] 
      #
      # @example
      #
      #   recipient = mailup.console.recipient
      #
      def recipient
        Recipient.new @api
      end

      # Create a user object
      #
      # @return [MailUp::Console::User] 
      #
      # @example
      #
      #   user = mailup.console.user
      #
      def user
        User.new @api
      end

    end
  end
end