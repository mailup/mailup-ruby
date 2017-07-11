# Mailup Ruby

A Ruby gem for interacting with the MailUp REST API.

[![Build Status](https://travis-ci.org/mailup/mailup-ruby.svg)](https://travis-ci.org/mailup/mailup-ruby)
[![Coverage Status](https://img.shields.io/coveralls/mailup/mailup-ruby.svg)](https://coveralls.io/r/mailup/mailup-ruby)
[![Code Climate](https://codeclimate.com/github/mailup/mailup-ruby/badges/gpa.svg)](https://codeclimate.com/github/mailup/mailup-ruby)
[![Dependency Status](https://gemnasium.com/mailup/mailup-ruby.svg)](https://gemnasium.com/mailup/mailup-ruby)
## Installation

Install the gem directly:

```ruby
gem install mailup
```

Or, add this line to your application's Gemfile:

```ruby
gem 'mailup'
```

## Usage

Be sure that you have OAuth2 tokens for the MailUp REST API before using this gem. If you are using [Omniauth](https://github.com/intridea/omniauth), there is a [MailUp strategy](https://github.com/tatemae-consultancy/omniauth-mailup) available.

### Credentials

Once you've gone through the OAuth process, and you have obtained your tokens, you need to provide your `client_id`, `client_secret` and OAuth2 tokens in a `credentials` hash to get started.

```ruby
require 'mailup'

credentials = {
  client_id: ENV['MAILUP_CLIENT_ID'],
  client_secret: ENV['MAILUP_CLIENT_SECRET'],
  oauth: {
    token: "...",
    refresh_token: "...",
    expires_at: 1234567890
  }
}

mailup = MailUp::API.new(credentials)
```

### Console Methods

Check out the [console methods API documentation](http://help.mailup.com/display/mailupapi/Standard+resources) for more information.

```ruby
lists = mailup.console.user.lists
lists['Items'].first['Name']
# => "Test List"
list_id = lists['Items'].first['idList'].to_i
# => 1
list = mailup.console.list(list_id)
groups = list.groups(pageNumber: 1, pageSize: 25)
groups['IsPaginated']
# => true
groups['PageNumber']
# => 1
groups['PageSize']
# => 25
groups['Skipped']
# => 25
groups['TotalElementsCount']
# => 35
groups['Items'].size
# => 10
```

### Email Statistics Methods

Check out the [email statistics API documentation](http://help.mailup.com/display/mailupapi/Email+Statistics) for more information.

```ruby
views_count = mailup.stats.message(17).views_count
# => 250

fields = mailup.stats.recipient(5).fields
# => {"IsPaginated"=>true, "Items"=>[{"Description"=>"AllOrderedProductIDs", "Id"=>26}, ...], ...}
```
