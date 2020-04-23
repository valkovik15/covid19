# frozen_string_literal: true

require 'date'
require 'covid19/configuration'
require 'covid19/request'
require 'covid19/client/help'
require 'covid19/client/reports'
require 'covid19/client/totals'
require 'json'

module Covid19
  # Class responsible for all the gem functionality
  class Client
    include Covid19::Request
    include Covid19::Client::Help
    include Covid19::Client::Reports
    include Covid19::Client::Totals
    attr_accessor(*Configuration::VALID_OPTIONS_KEYS)

    def initialize(options = {})
      options = Covid19.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    private
    def json_response(url, params = {})
      JSON.parse(get(url, params), symbolize_names: true)
    rescue JSON::ParserError
      {}
    end
  end
end
