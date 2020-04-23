# frozen_string_literal: true

require 'covid19/version'
require 'covid19/client'

# Ruby wrapper to COVID-19 data API
module Covid19
  extend Configuration

  class << self
    def new(options = {})
      Covid19::Client.new(options)
    end

    # Delegate to Client
    def method_missing(method, *args, &block)
      return super unless new.respond_to?(method)

      new.send(method, *args, &block)
    end

    def respond_to?(method_name, include_private = false)
      new.respond_to?(method_name, include_private) || super(method_name, include_private)
    end

    def respond_to_missing?(method_name, include_private = false)
      new.respond_to?(method_name, include_private) || super(method_name, include_private)
    end
  end
end
