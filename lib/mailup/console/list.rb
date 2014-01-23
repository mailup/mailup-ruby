module MailUp
  module Console
    class List
      attr_accessor :api

      def initialize(id, api)
          @api = api
          @id = id
      end

      # Retrieve groups for the specified list
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
      # @see http://help.mailup.com/display/mailupapi/Console+methods+v1.1#Consolemethodsv1.1-GetConsoleGroupsByList
      # 
      # @example
      #
      #   list = mailup.console.list(2)
      #   groups = list.groups
      #   groups['TotalElementsCount']
      #   => 10
      #
      #   groups = mailup.console.list(2).groups(pageNumber: 0, pageSize: 1)
      #
      def groups(params = {})
        @api.get("#{@api.path}/List/#{@id}/Groups", params: params)
      end
      
      # Create a new group for the specified list.
      #
      # @param [Hash] group A hash of group attributes.
      # @option group [String] :Name of the group (required).
      # @option group [String] :Notes to associate with the group (required).
      # @option group [Boolean] :Deletable to flag whether the group can be deleted (required).
      #
      # @return [JSON] The new Group including:
      #   * idList [Integer]
      #   * idGroup [Integer]
      #   * Name [String]
      #   * Notes [String]
      #   * Deletable [Boolean]
      #
      # @see http://help.mailup.com/display/mailupapi/Console+methods+v1.1#Consolemethodsv1.1-CreateGroup
      # 
      # @example
      #
      #   group = {
      #     Name: "New Group",
      #     Notes: "Created with mailup-rest gem",
      #     Deletable: true
      #   }
      #   new_group = mailup.console.list(2).add_group(group)
      #   new_group['idGroup']
      #   => 18
      #
      def add_group(group)
        @api.post("#{@api.path}/List/#{@id}/Group", body: group)
      end
      
      # Update a group for the specified list.
      #
      # @param [Hash] group A hash of group attributes.
      # @option group [String] :Name of the group (required).
      # @option group [String] :Notes to associate with the group (required).
      # @option group [Boolean] :Deletable to flag whether the group can be deleted (required).
      #
      # @return [JSON] The updated Group including:
      #   * idList [Integer]
      #   * idGroup [Integer]
      #   * Name [String]
      #   * Notes [String]
      #   * Deletable [Boolean]
      #
      # @see http://help.mailup.com/display/mailupapi/Console+methods+v1.1#Consolemethodsv1.1-UpdateGroup
      # 
      # @example
      #
      #   group = {
      #     Name: "Updated Group",
      #     Notes: "Updated with mailup-rest gem",
      #     Deletable: true
      #   }
      #   update = mailup.console.list(2).update_group(50, group)
      #   update['idGroup']
      #   => "Updated Title"
      #
      def update_group(group_id, group)
        @api.put("#{@api.path}/List/#{@id}/Group/#{group_id}", body: group)
      end
      
      # Delete a group from the specified list.
      #
      # @param [Integer] group_id The ID of the group to delete.
      #
      # @return [Boolean] `true` if successful
      #
      # @see http://help.mailup.com/display/mailupapi/Console+methods+v1.1#Consolemethodsv1.1-DeleteGroup
      #
      # Example:
      #
      #   delete = mailup.console.list(2).delete_group(49)
      #   => true
      #
      def delete_group(group_id)
        @api.delete("#{@api.path}/List/#{@id}/Group/#{group_id}")
      end

      # Retrieve the groups subscribed by the recipient in the specified list.
      #
      # @param [Integer] recipient_id The ID of the recipient.
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
      # @see http://help.mailup.com/display/mailupapi/Console+methods+v1.1#Consolemethodsv1.1-GetConsoleGroupsByRecipient
      # 
      # @example
      #
      #   groups = mailup.console.list(2).recipient_groups(5)
      #   groups['TotalElementsCount']
      #   => 3
      #   groups['Items'].first['Name']
      #   => "Group Name"
      #
      #   groups = mailup.console.list(2).recipient_groups(5, pageNumber: 0, pageSize: 1)
      #
      def recipient_groups(recipient_id, params = {})
        @api.get("#{@api.path}/List/#{@id}/Recipient/#{recipient_id}/Groups", params: params)
      end
      
      # Retrieve pending recipients in the specified list.
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
      # @see http://help.mailup.com/display/mailupapi/Console+methods+v1.1#Consolemethodsv1.1-GetPendingRecipientsByList
      # 
      # @example
      #
      #   pending = mailup.console.list(2).pending
      #   pending['TotalElementsCount']
      #   => 3
      #   pending['Items'].first['Name']
      #   => "Joe Public"
      #
      #   pending = mailup.console.list(2).pending(pageNumber: 0, pageSize: 1)
      #
      def pending(params = {})
        @api.get("#{@api.path}/List/#{@id}/Recipients/Pending", params: params)
      end
      
      # Retrieve subscribed recipients in the specified list.
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
      # @see http://help.mailup.com/display/mailupapi/Admin+Console+Methods#AdminConsoleMethods-GetSubscribedRecipientsByList
      # 
      # @example
      #
      #   subscribed = mailup.console.list(2).subscribed
      #   subscribed['TotalElementsCount']
      #   => 10
      #   subscribed['Items'].first['Name']
      #   => "Joe Public"
      #
      #   subscribed = mailup.console.list(2).subscribed(pageNumber: 0, pageSize: 1)
      #
      def subscribed(params = {})
        @api.get("#{@api.path}/List/#{@id}/Recipients/Subscribed", params: params)
      end
      
      # Retrieve unsubscribed recipients in the specified list.
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
      # @see http://help.mailup.com/display/mailupapi/Console+methods+v1.1#Consolemethodsv1.1-GetUnsubscribedRecipientsByList
      # 
      # @example
      #
      #   unsubscribed = mailup.console.list(2).unsusbcribed
      #   unsubscribed['TotalElementsCount']
      #   => 10
      #   unsubscribed['Items'].first['Name']
      #   => "Joe Public"
      #
      #   unsubscribed = mailup.console.list(2).unsusbcribed(pageNumber: 0, pageSize: 1)
      #
      def unsubscribed(params = {})
        @api.get("#{@api.path}/List/#{@id}/Recipients/Unsubscribed", params: params)
      end
      
      # Import multiple recipients to a list.
      #
      # @param [Array<Hash>] recipients An array of Recipients.
      #   * idRecipient [Integer] (optional)
      #   * Name [String]
      #   * Email [String]
      #   * MobilePrefix [String]
      #   * MobileNumber [String]
      #   * Fields [Array]
      #
      # @return [Integer] The number of imported recipients.
      #
      # @see http://help.mailup.com/display/mailupapi/Console+methods+v1.1#Consolemethodsv1.1-AsyncImportRecipientsToList
      #
      def import_recipients(recipients)
        @api.post("#{@api.path}/List/#{@id}/Recipients", body: recipients)
      end
      
      # Subscribe a recipient from the specified list.
      #
      # @param [Integer] recipient_id The ID of the recipient.
      #
      # @return [Boolean] `true` if successful.
      #
      # @see http://help.mailup.com/display/mailupapi/Console+methods+v1.1#Consolemethodsv1.1-SubscribeRecipientToList
      #
      # @example
      #
      #   susbcribe = mailup.console.list(2).subscribe(126)
      #   => true
      #
      def subscribe(recipient_id)
        @api.post("#{@api.path}/List/#{@id}/Subscribe/#{recipient_id}")
      end
      
      # Unsubscribe a recipient in the specified list.
      #
      # @param [Integer] recipient_id The ID of the recipient.
      #
      # @return [Boolean] `true` if successful.
      #
      # @see http://help.mailup.com/display/mailupapi/Console+methods+v1.1#Consolemethodsv1.1-RemoveRecipientFromList
      #
      # @example
      #
      #   unsusbcribe = mailup.console.list(2).unsubscribe(126)
      #   => true
      #
      def unsubscribe(recipient_id)
        @api.delete("#{@api.path}/List/#{@id}/Unsubscribe/#{recipient_id}")
      end
      
      # Get the enabled tag list for the specified list id.
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
      # @see http://help.mailup.com/display/mailupapi/Console+methods+v1.1#Consolemethodsv1.1-GetTags
      #
      # @example
      #
      #   tags = mailup.console.list(2).tags
      #   tags['TotalElementsCount']
      #   => 10
      #   tags['Items'].first['Enabled']
      #   => true
      #
      def tags(params = {})
        @api.get("#{@api.path}/List/#{@id}/Tags", params: params)
      end
      alias_method :enabled_tags, :tags
      
      # Add a new tag in the specified list.
      #
      # @param [String] name The name of the tag to create.
      #
      # @return [JSON] The created Tag with the following attributes:
      #   * Id [Integer]
      #   * Name [String]
      #   * Enabled [Boolean]
      #
      # @see http://help.mailup.com/display/mailupapi/Console+methods+v1.1#Consolemethodsv1.1-CreateTag
      # 
      # @example
      #
      #   new_tag = mailup.console.list(2).add_tag("My New Tag")
      #
      def add_tag(tag)
        @api.post("#{@api.path}/List/#{@id}/Tag", body: tag)
      end
      
      # Update a tag in the specified list.
      #
      # @param [Hash] tag A hash of tag attributes:
      # @option tag [String] :Name of the tag (required).
      # @option tag [Boolean] :Enabled true if tag is enabled.
      #
      # @return [JSON] The updated Tag with the following attributes:
      #   * Id [Integer]
      #   * Name [String]
      #   * Enabled [Boolean]
      #
      # @see http://help.mailup.com/display/mailupapi/Console+methods+v1.1#Consolemethodsv1.1-UpdateTag
      #
      # @example
      #
      #   tag = {
      #     Id: 1,
      #     Name: "Updated Tag",
      #     Enabled: false
      #   }
      #   updated_tag = mailup.console.list(2).update_tag(1, tag)
      #   updated_tag
      #   => false
      #
      def update_tag(tag_id, tag)
        @api.put("#{@api.path}/List/#{@id}/Tag/#{tag_id}", body: tag)
      end
      
      # Delete a tag from the specified list.
      #
      # @param [Integer] idTag The ID of the tag to delete.
      #
      # @return [Boolean] `true` if successful.
      #
      # @see http://help.mailup.com/display/mailupapi/Console+methods+v1.1#Consolemethodsv1.1-DeleteTag
      #
      # Example:
      #
      #   delete = mailup.console.list(2).delete_tag(1)
      #   => true
      #
      def delete_tag(tag_id)
        @api.delete("#{@api.path}/List/#{@id}/Tag/#{tag_id}")
      end
      
      # Get the attachment list for the specific message.
      #
      # @param [Integer] message_id The ID of the message.
      # @param [Hash] params Optional params or filters:
      # @option params [Integer] :pageNumber The page number to return.
      # @option params [Integer] :pageSize The number of results to per page.
      # @option params [String] :filterby A filtering expression.
      # @option params [String] :orderby The sorting condition for the results.
      #
      # @return [JSON] An array of Attachments with the following attributes:
      #   * Slot [Integer]
      #   * Name [String]
      #   * Path [String]
      #
      # @see http://help.mailup.com/display/mailupapi/Console+methods+v1.1#Consolemethodsv1.1-GetMessageAttachments
      #
      # @example
      #
      #   attachments = mailup.console.list(2).attachments(34)
      #   attachments.size
      #   => 3
      #
      def attachments(message_id, params = {})
        @api.get("#{@api.path}/List/#{@id}/Email/#{message_id}/Attachment", params: params)
      end
      
      # Add an attachment to the specified message.
      #
      # @param [Integer] message_id The ID of the message.
      # @param [Integer] slot The slot for the attachment.
      # @param [Hash] attachment A hash of recipient attributes:
      # @option attachment [String] :Name of the attachment (required).
      # @option attachment [String] :Path of the attachment (required).
      #
      # @return [JSON] The created Attachment with the following attributes:
      #   * Slot [Integer]
      #   * Name [String]
      #   * Path [String]
      #
      # @see http://help.mailup.com/display/mailupapi/Console+methods+v1.1#Consolemethodsv1.1-AddMessageAttachments
      # 
      # @example
      #
      #   attachment = {
      #     Name: "PDF Attachment",
      #     Path: "https://abc123.mailup.com/attachments/..."
      #   }
      #   attach = mailup.console.list(2).add_attachment(24, 1, attachment)
      #   attach.Name
      #   => "PDF Attachment"
      #
      def add_attachment(message_id, slot, attachment)
        @api.post("#{@api.path}/List/#{@id}/Email/#{message_id}/Attachment/#{slot}", body: attachment)
      end
      
      # Delete an attachment from the specified message.
      #
      # @param [Integer] message_id The ID of the message.
      # @param [Integer] slot The slot of the attachment.
      #
      # @return [Boolean] `true` if successful.
      #
      # @see http://help.mailup.com/display/mailupapi/Console+methods+v1.1#Consolemethodsv1.1-DeleteMessageAttachments
      #
      # Example:
      #
      #   delete = mailup.console.list(2).delete_attachment(49, 3)
      #   => true
      #
      def delete_attachment(message_id, slot)
        @api.delete("#{@api.path}/List/#{@id}/Email/#{message_id}/#{slot}")
      end
      
      # Get all the images for the specified list.
      #
      # @param [Hash] params Optional params or filters:
      # @option params [Integer] :pageNumber The page number to return.
      # @option params [Integer] :pageSize The number of results to per page.
      # @option params [String] :filterby A filtering expression.
      # @option params [String] :orderby The sorting condition for the results.
      #
      # @return [Array<String>] An array of Image strings.
      #
      # @see http://help.mailup.com/display/mailupapi/Console+methods+v1.1#Consolemethodsv1.1-GetListImages
      #
      # @example
      #
      #   images = mailup.console.list(2).images
      #   images.size
      #   => 3
      #
      def images(params = {})
        @api.get("#{@api.path}/List/#{@id}/Images", params: params)
      end
      
      # Add a new image to the specified mailing list.
      #
      # @param [Hash] image A hash of Image attributes.
      # @option image [String] Name of the image (required).
      # @option image [String] Data Base64 data for the image (required).
      #
      # @return [String] the created Image URL.
      #
      # @see http://help.mailup.com/display/mailupapi/Console+methods+v1.1#Consolemethodsv1.1-AddListImage
      # 
      # @example
      #
      #   image = {
      #     Name: "New Image",
      #     Data: "..."
      #   }
      #   new_image = mailup.console.list(2).add_image(image)
      #   => "https://mailup.com/images/..."
      #
      def add_image(image)
        @api.post("#{@api.path}/List/#{@id}/Images", body: image)
      end
      
      # Create an email message in the specified list id from template.
      #
      # @param [Integer] template_id The ID of the template.
      #
      # @return [JSON] The created Message with the following attributes:
      #   * idList [Integer]
      #   * idMessage [Integer]
      #   * Subject [String]
      #
      # @see http://help.mailup.com/display/mailupapi/Console+methods+v1.1#Consolemethodsv1.1-CreateEmailMessageFromTemplate
      # 
      # @example
      #
      #   new_message = mailup.console.list(2).add_message_from_template(5)
      #   new_message['Subject']
      #   => "Subject From Template"
      #
      def add_message_from_template(template_id)
        @api.post("#{@api.path}/List/#{@id}/Email/Template/#{template_id}")
      end
      
      # Create an email message in the specified list id.
      #
      # @param [Hash] message A hash of Message attributes:
      # @option message [String] :Subject of the message (required).
      # @option message [String] :Content of the message (required).
      # @option message [String] :Notes of the message (required).
      # @option message [Boolean] :IsConfirmation if it's a confirmation (required).
      # @option message [Boolean] :Embed this message (required).
      # @option message [Array] :Fields to include (See {MailUp::Console::Email#fields}).
      # @option message [Array] :Tags to include (See {#enabled_tags}).
      #
      # @return [JSON] The created Message with the following attributes:
      #   * idList [Integer]
      #   * idMessage [Integer]
      #   * Subject [String]
      #
      # @see http://help.mailup.com/display/mailupapi/Console+methods+v1.1#Consolemethodsv1.1-CreateEmailMessage
      # 
      # @example
      #
      #   new_message = mailup.console.list(2).add_message(message)
      #   new_message['Subject']
      #   => "Message Subject"
      #
      def add_message(message)
        @api.post("#{@api.path}/List/#{@id}/Email", body: message)
      end
      
      # Modify an email message in the specified list id.
      #
      # @param [Integer] message_id The ID of the message.
      # @param [Hash] message A hash of message attributes:
      # @option message [String] :Subject of the message (required).
      # @option message [String] :Content of the message (required).
      # @option message [String] :Notes of the message (required).
      # @option message [Boolean] :IsConfirmation if it's a confirmation (required).
      # @option message [Boolean] :Embed this message (required).
      # @option message [Array] :Fields to include (See {MailUp::Console::Email#fields}).
      # @option message [Array] :Tags to include (See {#enabled_tags}).
      #
      # @return [JSON] The updated Message with the following attributes:
      #   * idList [Integer]
      #   * idMessage [Integer]
      #   * Subject [String]
      #
      # @see http://help.mailup.com/display/mailupapi/Console+methods+v1.1#Consolemethodsv1.1-UpdateEmailMessage
      # 
      # @example
      #
      #   update = mailup.console.list(2).update_message(5, message)
      #   update['Subject']
      #   => "Updated Subject"
      #
      def update_message(message_id, message)
        @api.put("#{@api.path}/List/#{@id}/Email/#{message_id}", body: message)
      end
      
      # Modify the email message online visibility.
      #
      # @param [Integer] message_id The ID of the message.
      # @param [Boolean] visibility The visibility of the message.
      #
      # @return [Boolean] `true` if successful.
      #
      # @see http://help.mailup.com/display/mailupapi/Console+methods+v1.1#Consolemethodsv1.1-UpdateOnlineEmailMessageVisibility
      # 
      # @example
      #
      #   update = mailup.console.list(2).update_message_visibility(5, true)
      #   => true
      #
      def update_message_visibility(message_id, visibility)
        @api.put("#{@api.path}/List/#{@id}/Email/#{message_id}/Online/Visibility", body: visibility)
      end
      
      # Delete an email message from the specified list id.
      #
      # @param [Integer] message_id The ID of the message.
      #
      # @return [Boolean] `true` if successful.
      #
      # @see http://help.mailup.com/display/mailupapi/Console+methods+v1.1#Consolemethodsv1.1-DeleteEmailMessage
      #
      # Example:
      #
      #   delete = mailup.console.list(2).delete_message(49)
      #   => true
      #
      def delete_message(message_id)
        @api.delete("#{@api.path}/List/#{@id}/Email/#{message_id}")
      end
      
      # Retrieve the email message details by specified id.
      #
      # @param [Integer] message_id The ID of the message.
      #
      # @return [JSON] The Message with the following attributes:
      #   * Attachments [Array]
      #   * Notes [String]
      #   * Content [String]
      #   * Fields [Array]
      #   * Tags [Array]
      #   * Embed [Boolean]
      #   * IsConfirmation [Boolean]
      #   * idList [Integer]
      #   * idMessage [Integer]
      #   * Subject [String]
      #
      # @see http://help.mailup.com/display/mailupapi/Console+methods+v1.1#Consolemethodsv1.1-GetMessageDetails
      # Example:
      #
      #   message = mailup.console.list(2).message_details(49)
      #   message['Subject']
      #   => "Message Subject"
      #
      def message_details(message_id)
        @api.get("#{@api.path}/List/#{@id}/Email/#{message_id}")
      end
      
      # Retrieve email messages (cloned and uncloned) for this list.
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
      # @see http://help.mailup.com/display/mailupapi/Console+methods+v1.1#Consolemethodsv1.1-GetMailMessagesByList
      #
      # @example
      #
      #   emails = mailup.console.list(2).emails
      #   emails['TotalElementsCount']
      #   => 10
      #   emails['Items'].first['Subject']
      #   => "Test Subject"
      #   emails['Items'].first['idList']
      #   => 2
      #
      def emails(params = {})
        @api.get("#{@api.path}/List/#{@id}/Emails", params: params)
      end
      
      # Retrieve the email messages visible online through the website by the specified list id.
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
      # @see http://help.mailup.com/display/mailupapi/Console+methods+v1.1#Consolemethodsv1.1-GetPublishedMailMessagesByList
      #
      # @example
      #
      #   emails = mailup.console.list(2).online_emails
      #   emails['TotalElementsCount']
      #   => 10
      #   emails['Items'].first['Subject']
      #   => "Test Subject"
      #   emails['Items'].first['idList']
      #   => 1
      #
      def online_emails(params = {})
        @api.get("#{@api.path}/List/#{@id}/Online/Emails", params: params)
      end
      alias_method :visible_emails, :online_emails

      # Retrieve the archived email messages by the specified list id.
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
      # @see http://help.mailup.com/display/mailupapi/Console+methods+v1.1#Consolemethodsv1.1-GetArchivedMailMessagesByList
      #
      # @example
      #
      #   emails = mailup.console.list(2).archived_emails
      #   emails.size
      #   => 10
      #   emails['Items'].first['Subject']
      #   => "Test Subject"
      #   emails['Items'].first['idList']
      #   => 1
      #
      def archived_emails(params = {})
        @api.get("#{@api.path}/List/#{@id}/Archived/Emails", params: params)
      end
      
      # Get email message send history.
      #
      # @param [Integer] message_id The ID of the message.
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
      # @see http://help.mailup.com/display/mailupapi/Console+methods+v1.1#Consolemethodsv1.1-GetMailMessageSendHistory
      #
      # @example
      #
      #   history = mailup.console.list(2).send_history(5)
      #   history['TotalElementsCount']
      #   => 10
      #
      def send_history(message_id, params = {})
        @api.get("#{@api.path}/List/#{@id}/Email/#{message_id}/SendHistory", params: params)
      end
      
      # Send an email message to the recipients in the specified list.
      #
      # @param [Integer] message_id The ID of the list.
      #
      # @return [JSON] A Send object with the following attributes:
      #   * idMessage [Integer]
      #   * Sent [Integer]
      #   * UnprocessedRecipients [Array]
      #   * InvalidRecipients [Array]
      #
      # @see http://help.mailup.com/display/mailupapi/Console+methods+v1.1#Consolemethodsv1.1-SendMailMessageToRecipientInList
      #
      # @example
      #
      #   send = mailup.console.list(2).send_message(5)
      #   send['Sent']
      #   => 1794
      #
      def send_message(message_id)
        @api.post("#{@api.path}/List/#{@id}/Email/#{message_id}/Send")
      end
      
      # Retrieve the list of the current defined message templates in the specified list.
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
      # @see http://help.mailup.com/display/mailupapi/Console+methods+v1.1#Consolemethodsv1.1-GetEmailTemplates
      #
      # @example
      #
      #   templates = mailup.console.list(2).templates
      #   templates['TotalElementsCount']
      #   => 10
      #   templates['Items'].first['Id']
      #   => 278
      #
      def templates(params = {})
        @api.get("#{@api.path}/List/#{@id}/Templates", params: params)
      end
      
      # Retrieve the details for the specified message template in the specified list.
      #
      # @param [Integer] template_id The ID of the template.
      # @param [Hash] params Optional params or filters:
      # @option params [Integer] :pageNumber The page number to return.
      # @option params [Integer] :pageSize The number of results to per page.
      # @option params [String] :filterby A filtering expression.
      # @option params [String] :orderby The sorting condition for the results.
      #
      # @return [JSON>] A Template object with the following attributes:
      #   * Content [String]
      #   * Id [Integer]
      #   * Title [String]
      #   * Text [String]
      #   * Thumbnail [String]
      #
      # @see http://help.mailup.com/display/mailupapi/Console+methods+v1.1#Consolemethodsv1.1-GetEmailTemplateDetails
      #
      # @example
      #
      #   template = mailup.console.list(2).template_details(15)
      #   template.Id
      #   => 15
      #
      def template_details(template_id)
        @api.get("#{@api.path}/List/#{@id}/Templates/#{template_id}")
      end
        
    end
  end
end