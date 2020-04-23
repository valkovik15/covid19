# frozen_string_literal: true

require 'covid19/version'
require 'covid19'
require 'yaml'

module Covid19
  # Module to set client options
  module Configuration
    # An array of valid keys in the options hash when configuring a {Covid19::Client}
    VALID_OPTIONS_KEYS = %i[
      host
      key
      user_agent
    ].freeze

    # Set the default API endpoint
    DEFAULT_HOST = ENV['COVID_HOST'] || 'covid-19-data.p.rapidapi.com'

    # Set the default credentials
    DEFAULT_KEY = ENV['COVID_API_KEY']

    # Set the default 'User-Agent' HTTP header
    DEFAULT_USER_AGENT = "Covid19 #{Covid19::VERSION}"

    attr_accessor(*VALID_OPTIONS_KEYS)

    # When this module is extended, set all configuration options to their default values
    def self.extended(base)
      base.reset
    end

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
    end

    # Create a hash of options and their values
    def options
      options = {}
      VALID_OPTIONS_KEYS.each { |k| options[k] = send(k) }
      options
    end

    # Reset all configuration options to defaults
    def reset
      self.host       = DEFAULT_HOST
      self.key        = DEFAULT_KEY
      self.user_agent = DEFAULT_USER_AGENT
      self
    end
  end
end
