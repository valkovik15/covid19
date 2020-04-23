# frozen_string_literal: true

RSpec.describe Covid19::Client::Help do
  before do
    Covid19.configure do |config|
      config.key = 'random-key'
    end
    stub_get('/help/countries')
      .to_return(body: fixture('countries.json'))
    stub_get('/docs.json')
      .to_return(body: fixture('documentation.json'))
  end

  describe '.countries_list' do
    it 'returns list of available countries' do
      countries = Covid19.countries_list
      expect(a_get('/help/countries')).to have_been_made
      expect(countries[0].keys).to include(:name, :alpha2code, :alpha3code, :latitude, :longitude)
    end
  end

  describe '.documentation' do
    it 'returns documentation for API' do
      docs = Covid19.documentation
      expect(a_get('/docs.json')).to have_been_made
      expect(docs.keys).to include(:openapi)
    end
  end
end
