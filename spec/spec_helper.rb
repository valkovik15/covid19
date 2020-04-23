# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
end

require 'bundler/setup'
require 'covid19'
require 'rspec'
require 'webmock/rspec'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  def api_url(url)
    "https://#{Covid19.host}#{url}"
  end

  def a_get(url)
    a_request(:get, api_url(url))
  end

  def stub_get(url)
    stub_request(:get, api_url(url))
  end

  def fixture_path
    File.expand_path('fixtures', __dir__)
  end

  def fixture(file)
    File.new(fixture_path + '/' + file)
  end
end
