# frozen_string_literal: true

module Covid19
  class Client
    # Methods to retrieve the data for some past date
    module Reports
      # Get report for certain date on all countries of the world.
      # @param date [Date] date, for which report will be created
      # @return [Array<Hash>]
      # @example
      #   Covid19.all_countries_report
      def all_countries_report(date:)
        json_response('/report/country/all', { date: date.strftime('%F') })
      end

      # Get daily report data for the whole world.
      # @param date [Date] date, for which report will be created
      # @return [Array<Hash>]
      # @example
      #   Covid19.world_report
      def world_report(date:)
        json_response('/report/totals', { date: date.strftime('%F') })
      end

      # Get a daily report for the specific date and country.
      # @param date [Date] date, for which report will be created
      # @param country [String] country, Alpha-2, Alpha-3 code of country for which report will be created
      # @return [Array<Hash>]
      # @example
      #   Covid19.country_report(date: Date.today.prev_day, country: 'Italy')
      #   Covid19.country_report(date: Date.today.prev_day, country: 'it')
      def country_report(date:, country:)
        if country.length > 3
          json_response('/report/country/name', { date: date.strftime('%F'),
                                                  name: country.downcase.capitalize })
        else
          json_response('/report/country/code', { date: date.strftime('%F'),
                                                  code: country.downcase })
        end
      end
    end
  end
end
