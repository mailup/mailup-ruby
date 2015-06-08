require 'oauth2'
require 'multi_json'
require "net/https"
require 'json'
require "uri"

require 'mailup/version'
require 'mailup/errors'
require 'mailup/console/base'
require 'mailup/console/email'
require 'mailup/console/group'
require 'mailup/console/images'
require 'mailup/console/import'
require 'mailup/console/list'
require 'mailup/console/recipient'
require 'mailup/console/user'
require 'mailup/public/base'
require 'mailup/public/console'
require 'mailup/stats/base'
require 'mailup/stats/message'
require 'mailup/stats/recipient'

module MailUp
  class API
    attr_accessor :access_token, :debug, :host, :path, :credentials

    # Initialize a new (thread-safe) API instance.
    #
    # @param [Hash] credentials for connecting to the MailUp API.
    #   * client_id [String]
    #   * client_secret [String]
    #   * oauth [Hash]
    #     * token [String]
    #     * refresh_token [String]
    #     * expires_at [Integer]
    # @param [Boolean] debug whether or not to raise errors.
    #
    # @example
    #
    #   credentials = {
    #     client_id: "1324567890",
    #     client_secret: "123abc456def",
    #     oauth: {
    #       token: "1324567890",
    #       refresh_token: "1324567890",
    #       expires_at: 123456789,
    #     }
    #   }
    #   mailup = MailUp::API.new(credentials)
    #
    def initialize(credentials=nil, debug=false)
      @debug = debug
      @host = 'https://services.mailup.com'
      @path = ''
      @credentials = credentials

      # Validate the credentials
      raise Error.new, 'MailUp credentials missing' if credentials.nil? or !credentials.is_a?(Hash)
      [:client_id, :client_secret, :oauth].each do |key|
        raise Error.new, "MailUp credentials must include a #{key.to_s} key" unless credentials.has_key?(key)
      end
      raise Error.new, 'MailUp credentials :oauth must be a hash' unless credentials[:oauth].is_a?(Hash)
      [:token, :refresh_token, :expires_at].each do |key|
        raise Error.new, "MailUp credentials :oauth hash must include a #{key.to_s} key" unless credentials[:oauth].has_key?(key)
      end

      # Create a OAuth2 client instance
      client = OAuth2::Client.new(
        credentials[:client_id],
        credentials[:client_secret],
        site: @host,
        authorize_url: "/Authorization/OAuth/LogOn",
        token_url: "/Authorization/OAuth/Token",
        raise_errors: @debug
      )

      # Create an access_token instance
      @access_token = OAuth2::AccessToken.new(
        client,
        credentials[:oauth][:token],
        {
          refresh_token: credentials[:oauth][:refresh_token],
          expires_at: credentials[:oauth][:expires_at]
        }
      )
    end

    # Make a request with the Access Token.
    #
    # @param [Symbol] verb the HTTP request method
    # @param [String] path the HTTP URL path of the request
    # @param [Hash] opts the options to make the request with
    #
    def request(method, path, opts={}, &block) # :nodoc:
      unless @access_token == nil
        # Refresh token if needed
        @access_token = @access_token.refresh! if @access_token.expired?
        # Ensure the body is JSON
        opts[:body] = MultiJson.dump(opts[:body]) if opts[:body]
        # Set the headers
        opts[:headers] ||= {}
        opts[:headers].merge!(headers)
        # Make the request
        req = @access_token.send(method, path, opts)
        # Handle the response
        handle_response(req)
      end
    end

    # Make a request with for Provisioning Calls.
    #
    # @param [Symbol] verb the HTTP request method
    # @param [String] path the HTTP URL path of the request
    # @param [Hash] opts the options to make the request with
    #
    def provisioning_request(path, body = nil) # :nodoc:
      uri = URI.parse(@host)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER

      req = Net::HTTP::Post.new(path, initheader = {'Content-Type' =>'application/json'})
      req.basic_auth @credentials[:client_id], @credentials[:client_secret]
      req.body = body.to_json

      http.request(req).body.to_json
    end

    # Make a GET request with the Access Token
    # @see #request
    #
    def get(path, opts={}, &block) # :nodoc:
      request(:get, path, opts, &block)
    end

    # Make a POST request with the Access Token
    # @see #request
    #
    def post(path, opts={}, &block) # :nodoc:
      request(:post, path, opts, &block)
    end

    # Make a PUT request with the Access Token
    # @see #request
    #
    def put(path, opts={}, &block) # :nodoc:
      request(:put, path, opts, &block)
    end

    # Make a PATCH request with the Access Token
    # @see #request
    #
    def patch(path, opts={}, &block) # :nodoc:
      request(:patch, path, opts, &block)
    end

    # Make a DELETE request with the Access Token
    # @see #request
    #
    def delete(path, opts={}, &block) # :nodoc:
      request(:delete, path, opts, &block)
    end

    # Handle the response of a request
    def handle_response(response) # :nodoc:
      case response.status
      when 400
        raise BadRequest.new response.parsed
      when 401
        raise Unauthorized.new
      when 404
        raise NotFound.new
      when 400...500
        raise ClientError.new response.parsed
      when 500...600
        raise ServerError.new
      else
        case response.body
        when ''
          true
        when is_a?(Integer)
          response.body
        else
          response.parsed
        end
      end
    end

    # Set the request headers
    def headers # :nodoc:
      {
        'User-Agent' => "mailup-ruby-#{VERSION}",
        'Content-Type' => 'application/json; charset=utf-8',
        'Accept' => 'application/json'
      }
    end

    # Access the console API methods
    #
    # @example
    #
    #   lists = mailup.console.user.lists
    #
    def console
      Console::Base.new self
    end

    # Access the public API methods
    #
    # @example
    #
    #   activation = mailup.public.activation.new(...)
    #
    def public
      Public::Base.new self
    end

    # Access the email statistics API methods
    #
    # @example
    #
    #   views = mailup.stats.message.views_count(1)
    #
    def stats
      Stats::Base.new self
    end

  end
end