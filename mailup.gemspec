# lib = File.expand_path('../lib', __FILE__)
lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mailup/version'

Gem::Specification.new do |gem|
  gem.name          = 'mailup'
  gem.version       = MailUp::VERSION
  gem.platform      = Gem::Platform::RUBY
  gem.authors       = ['Brian Getting', 'Rocco Galluzzo']
  gem.email         = ['brian@tatem.ae']
  gem.homepage      = 'https://github.com/mailup/mailup-ruby'
  gem.summary       = 'Ruby wrapper for the MailUp REST API'
  gem.description   = 'A Ruby gem for interacting with the MailUp REST API.'
  gem.licenses      = ['MIT']

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_runtime_dependency 'oauth2', '~> 1.4', '>= 1.4'

  gem.add_development_dependency 'coveralls'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
end
