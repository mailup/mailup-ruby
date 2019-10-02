# frozen_string_literal: true

module MailUp
  module Console
    class Images
      attr_accessor :api

      def initialize(api)
        @api = api
      end

      # Get the list of all shared images for the current console.
      #
      # @return [Array<String>] An array of Image strings.
      #
      # @see http://help.mailup.com/display/mailupapi/Console+methods+v1.1#Consolemethodsv1.1-GetSharedImages
      #
      # @example
      #
      #   images = mailup.console.images.list
      #   images.size
      #   => 50
      #
      def list
        @api.get("#{@api.path}/Images")
      end

      # Add a new image to the shared images list.
      #
      # @param [Hash] image A hash of image attributes:
      # @option image [String] Name of the image.
      # @option image [String] Base64 data for the image.
      #
      # @return [Array] An array of Image strings.
      #
      # @see http://help.mailup.com/display/mailupapi/Console+methods+v1.1#Consolemethodsv1.1-AddSharedImage
      #
      # @example
      #
      #   image = {
      #     Name: "TemplateHeader.jpg",
      #     Data: "..."
      #   }
      #   images = mailup.console.images.add_image(image)
      #   images.size
      #   => 51
      #
      def add_image(image)
        @api.post("#{@api.path}/Images", body: image)
      end

      # Delete the image corresponding to the provided full path name.
      #
      # @param [String] path The path of the image to delete.
      #
      # @return [Boolean] `true` if successful.
      #
      # @see http://help.mailup.com/display/mailupapi/Console+methods+v1.1#Consolemethodsv1.1-DeleteImage
      #
      # @example
      #
      #   delete = mailup.console.images.delete_image("#{image_path}")
      #   => true
      #
      def delete_image(path)
        @api.delete("#{@api.path}/Images", body: path.to_s)
      end
    end
  end
end
