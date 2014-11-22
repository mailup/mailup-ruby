module MailUp
  module Public
    class Console
      attr_accessor :api

      def initialize(api)
          @api = api
      end

      # Create a new trial console.
      # 
      # @param [Hash] account A hash of account attributes.
      # @option params [String] :NameAndSurname The company name.
      # @option params [String] :Email The email address for the trial account.
      # @option params [String] :Company The company name.
      # @option params [String] :Language The account language.
      # @option params [Boolean] :IsUSA Is this a US account?
      # @option params [Boolean] :RegisterToNewsletter Does this account accept marketing?
      #
      # @return [JSON] The trial console including:
      #   * Hash [String]
      #   * Id [Integer]
      #
      # @see http://help.mailup.com/display/mailupapi/Public+methods+v1.1#Publicmethodsv1.1-RequestNewTrialConsole
      #
      # @example
      #
      #   account = {
      #     NameAndSurname: "Joe Public",
      #     Email: "joe@public.com",
      #     Company: "ACME",
      #     PhoneNumber: "15555551212",
      #     Language: "En",
      #     IsUSA: true,
      #     RegisterToNewsletter: true
      #   }
      #   trial = mailup.public.console.new(account)
      #   trial['id']
      #   => 1329874
      #
      def activate_trial(account = {})
        @api.provisioning_request("#{@api.path}/Console/TrialActivation", account)
      end

      # Retrieve the information about current trial activation status.
      # 
      # @param [Hash] account A hash of account attributes.
      # @option params [String] :Hash The Hash of the trial activation request.
      # @option params [Integer] :Id The Id of the trial activation request.
      #
      # @return [JSON] An activation status object including:
      #   * Code [Integer]
      #   * Descriptin [String]
      #
      # @see http://help.mailup.com/display/mailupapi/Public+methods+v1.1#Publicmethodsv1.1-RequestTrialConsoleActivationStatus
      #
      # @example
      #
      #   account = {
      #     Hash: "1k23hj432jh4kh3j24k",
      #     Id: "1324"
      #   }
      #   status = mailup.public.console.status(account)
      #   status['Code']
      #   => 1234
      #   status['Description']
      #   => "Status description..."
      #
      def status(account = {})
        @api.provisioning_request("#{@api.path}/Console/TrialActivationStatus", account)
      end

    end
  end
end