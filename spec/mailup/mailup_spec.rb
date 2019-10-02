# frozen_string_literal: true

require 'spec_helper'

describe MailUp::API do
  context 'initialization' do
    # Make sure a hash is provided
    it 'requires credentials' do
      expect { MailUp::API.new }.to raise_error(MailUp::Error, 'MailUp credentials missing')
    end

    # Validate the credentials hash keys
    %i[client_id client_secret oauth].each do |key|
      it "requires credentials to have a '#{key}' key" do
        @credentials.delete_if { |k, _v| k == key }
        expect { MailUp::API.new(@credentials) }.to raise_error(MailUp::Error, "MailUp credentials must include a #{key} key")
      end
    end

    # Make sure the oauth key is a hash
    it 'requires credentials to have an oauth hash' do
      @credentials[:oauth] = nil
      expect { MailUp::API.new(@credentials).merge!(token: true) }.to raise_error(MailUp::Error, 'MailUp credentials :oauth must be a hash')
    end

    # Validate the oauth hash keys
    %i[token refresh_token expires_at].each do |key|
      it "requires credentials with an oauth hash containing a '#{key}' key" do
        @credentials[:oauth].delete_if { |k, _v| k == key }
        expect { MailUp::API.new(@credentials) }.to raise_error(MailUp::Error, "MailUp credentials :oauth hash must include a #{key} key")
      end
    end
  end

  # Add a context for sending a request
  # Verify that each verb method sends the right message.
  # Verify that the objects exist.
end
