# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'
require 'mailup'
require 'coveralls'
Coveralls.wear!

# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'

  # Global hooks
  config.before(:each) { init_credentials }

  config.mock_with :rspec do |c|
    c.syntax = %i[should expect]
  end
  config.expect_with :rspec do |c|
    c.syntax = %i[should expect]
  end
end

# Create Credentials Hash
def init_credentials
  @credentials = {
    client_id: '1234',
    client_secret: '1234',
    oauth: {
      token: '123',
      refresh_token: '123',
      expires_at: 123
    }
  }
end

# Create MailUp Object
def init_mailup
  @mailup = MailUp::API.new(@credentials)
end
