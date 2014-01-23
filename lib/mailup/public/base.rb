module MailUp
  module Public
    class Base
      attr_accessor :api

      def initialize(api) # :nodoc:
          @api = api
          @api.path = "/API/v#{MailUp::API_VERSION}/Rest/PublicService.svc"
      end

      # Resource nodes
      def console
        Console.new @api
      end

    end
  end
end