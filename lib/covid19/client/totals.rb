# frozen_string_literal: true

module Covid19
  class Client
    # Methods to retrieve the latest data
    module Totals
      # Get latest data for a specific country.
      # @param country [String] country, Alpha-2, Alpha-3 code of country for which data will be given
      # @return [Array<Hash>]
      # @example
      #   Covid19.country_totals(country: 'Italy')
      #   Covid19.country_totals(country: 'it')
      def country_totals(country:)
        if country.length > 3
          json_response('/country', { name: country.downcase.capitalize })
        else
          json_response('/country/code', { code: country.downcase })
        end
      end

      # Get latest data for all countries of the world.
      #
      # @return [Array<Hash>]
      # @example
      #   Covid19.all_countries_totals
      def all_countries_totals
        json_response('/country/all')
      end

      # Get latest data for whole world.
      #
      # @return [Array<Hash>]
      # @example
      #   Covid19.world_totals
      def world_totals
        json_response('/totals')
      end
    end
  end
end
