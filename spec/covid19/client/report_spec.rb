# frozen_string_literal: true

RSpec.describe Covid19::Client::Reports do
  before do
    Covid19.configure do |config|
      config.key = 'random-key'
    end
    stub_get('/report/totals')
      .with(query: { date: '2020-04-20' })
      .to_return(body: fixture('world_for_date.json'))
    stub_get('/report/country/name')
      .with(query: { date: '2020-04-21', name: 'Belarus' })
      .to_return(body: fixture('country_for_date.json'))
    stub_get('/report/country/code')
      .with(query: { date: '2020-04-21', code: 'by' })
      .to_return(body: fixture('country_for_date.json'))
    stub_get('/report/country/all')
      .with(query: { date: '2020-04-21' })
      .to_return(body: fixture('all_countries_for_date.json'))
  end

  describe '.world_report' do
    it 'returns totals for the whole world on given date' do
      info = Covid19.world_report(date: Date.new(2020, 4, 20))
      expect(a_get('/report/totals').with(query: { date: '2020-04-20' })).to have_been_made
      expect(info[0].keys).to include(:confirmed, :recovered, :active, :deaths, :date)
      expect(info[0][:confirmed]).to be_a Numeric
      expect(info[0][:date]).to eq '2020-04-20'
    end
  end

  describe '.country_report' do
    it 'returns totals for the given country and date by country\'s name' do
      info = Covid19.country_report(date: Date.new(2020, 4, 21), country: 'Belarus')
      expect(a_get('/report/country/name').with(query: { date: '2020-04-21', name: 'Belarus' })).to have_been_made
      expect(info[0].keys).to include(:country, :latitude, :longitude, :provinces, :date)
      expect(info[0][:date]).to eq '2020-04-21'
    end
    it 'returns totals for the given country and date by country\'s code' do
      info = Covid19.country_report(date: Date.new(2020, 4, 21), country: 'by')
      expect(a_get('/report/country/code').with(query: { date: '2020-04-21', code: 'by' })).to have_been_made
      expect(info[0].keys).to include(:country, :latitude, :longitude, :provinces, :date)
      expect(info[0][:date]).to eq '2020-04-21'
    end
  end

  describe '.all_countries_report' do
    it 'returns totals for all countries of the world for given date' do
      info = Covid19.all_countries_report(date: Date.new(2020, 4, 21))
      expect(a_get('/report/country/all').with(query: { date: '2020-04-21' })).to have_been_made
      expect(info[0].keys).to include(:country, :provinces, :latitude, :longitude, :date)
      expect(info[0][:date]).to eq '2020-04-21'
    end
  end
end
