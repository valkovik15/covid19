# frozen_string_literal: true

module Covid19
  class Client
    # Methods to help user start interaction with gem
    module Help
      # Get a Name, Alpha-2 code, Alpha-3 code, Latitude and Longitude for every country.
      #
      # @return [Array<Hash>]
      # @example
      #   Covid19.countries_list
      def countries_list
        json_response '/help/countries'
      end

      # Get OpenAPI Specification in JSON format
      #
      # @return [Hash]
      # @example
      #   Covid19.documentation
      def documentation
        json_response '/docs.json'
      end
    end
  end
end
