# frozen_string_literal: true

ENV["REDIS_URL"] ||= "redis://127.0.0.1:6379/5"

require "bundler/setup"
require "webmock"
require "vcr"
require "pry"
require "pry-remote"
require "byebug"
require "simplecov"
require "factory_bot"

SimpleCov.minimum_coverage 100
SimpleCov.use_merging false
SimpleCov.formatter = SimpleCov::Formatter::HTMLFormatter
SimpleCov.coverage_dir "coverage"
SimpleCov.add_filter "/spec/"
SimpleCov.add_filter "/lib/convertImage/version.rb"
SimpleCov.start "rails"

require "convertImage"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.include FactoryBot::Syntax::Methods
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

WebMock.disable_net_connect!(allow_localhost: true)

VCR.configure do |config|
  # the directory where your cassettes will be saved
  config.cassette_library_dir = "spec/vcr"
  config.default_cassette_options = { match_requests_on: %i[method uri path body headers] }

  # your HTTP request service.
  config.hook_into :webmock
  config.preserve_exact_body_bytes do |http_message|
    http_message.body.encoding.name == "ASCII-8BIT" ||
      !http_message.body.valid_encoding?
  end
  config.configure_rspec_metadata!
  config.before_http_request do |request|
    if request.uri == "http://fake.url"
      raise SocketError, "Failed to open TCP connection to fake.url 80 (getaddrinfo: Name or service not know)"
    end
  end

  config.register_request_matcher :headers do |r1, r2|
    if r1.uri.match(%r{auth/oauth2/token})
      r1.headers.except("Authorization") == r2.headers.except("Authorization")
    else
      r1.headers == r2.headers
    end
  end
end

# Load support files
Dir[File.join(File.dirname(__FILE__), "support", "**", "*.{rb,yml}").to_s].sort.each { |path| require path }
Dir[File.join(File.dirname(__FILE__), "factories", "**", "*_factory.rb").to_s].sort.each { |path| require path }
