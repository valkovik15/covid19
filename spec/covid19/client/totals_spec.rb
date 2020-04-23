# frozen_string_literal: true

RSpec.describe Covid19::Client::Totals do
  before do
    Covid19.configure do |config|
      config.key = 'random-key'
    end
    stub_get('/totals')
      .to_return(body: fixture('latest_world.json'))
    stub_get('/country/code')
      .with(query: { code: 'by' })
      .to_return(body: fixture('latest_country.json'))
    stub_get('/country')
      .with(query: { name: 'Belarus' })
      .to_return(body: fixture('latest_country.json'))
    stub_get('/country/all')
      .to_return(body: fixture('latest_all_countries.json'))
  end

  describe '.world_totals' do
    it 'returns latest totals for the whole world' do
      info = Covid19.world_totals
      expect(a_get('/totals')).to have_been_made
      expect(info[0].keys).to include(:confirmed, :recovered, :critical, :deaths)
      expect(info[0][:confirmed]).to be_a Numeric
    end
  end

  describe '.country_totals' do
    it 'returns totals for the given country by its name' do
      info = Covid19.country_totals(country: 'Belarus')
      expect(a_get('/country').with(query: { name: 'Belarus' })).to have_been_made
      expect(info[0].keys).to include(:country, :confirmed, :recovered, :critical, :deaths, :latitude, :longitude)
    end
    it 'returns totals for the given country by its code' do
      info = Covid19.country_totals(country: 'by')
      expect(a_get('/country/code').with(query: { code: 'by' })).to have_been_made
      expect(info[0].keys).to include(:country, :confirmed, :recovered, :critical, :deaths, :latitude, :longitude)
    end
  end

  describe '.all_countries_totals' do
    it 'returns latest totals for all countries of the world' do
      info = Covid19.all_countries_totals
      expect(a_get('/country/all')).to have_been_made
      expect(info[0].keys).to include(:country, :confirmed, :recovered, :critical, :deaths, :latitude, :longitude)
    end
  end
end
