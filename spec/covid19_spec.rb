# frozen_string_literal: true

RSpec.describe Covid19 do
  after do
    Covid19.reset
  end

  it 'has a version number' do
    expect(Covid19::VERSION).not_to be nil
  end

  context 'when delegating to a client' do
    before do
      stub_get('/totals')
        .to_return(body: fixture('latest_world.json'))
      Covid19.configure do |config|
        config.key = 'random-key'
      end
    end

    it 'gets the correct resource' do
      Covid19.world_totals
      expect(a_get('/totals')).to have_been_made
    end

    it 'returns the same results as a client' do
      expect(Covid19.world_totals).to eq Covid19::Client.new.world_totals
    end
  end

  describe '.respond_to?' do
    it 'returns true if a method exists' do
      expect(Covid19).to respond_to(:new)
    end
    it "returns false if a method doesn't exist" do
      expect(Covid19).not_to respond_to(:foo)
    end
  end

  describe '.new' do
    it 'returns a Covid19::Client' do
      expect(Covid19.new).to be_a Covid19::Client
    end
  end

  describe '.host' do
    it 'returns the default host' do
      expect(Covid19.host).to eq Covid19::Configuration::DEFAULT_HOST
    end
  end

  describe '.host=' do
    it 'sets the host' do
      Covid19.host = 'http://localhost:3000'
      expect(Covid19.host).to eq 'http://localhost:3000'
    end
  end

  describe '.user_agent' do
    it 'returns the default user agent' do
      expect(Covid19.user_agent).to eq Covid19::Configuration::DEFAULT_USER_AGENT
    end
  end

  describe '.user_agent=' do
    it 'sets the user agent' do
      Covid19.user_agent = 'Custom User Agent'
      expect(Covid19.user_agent).to eq 'Custom User Agent'
    end
  end

  describe '.configure' do
    Covid19::Configuration::VALID_OPTIONS_KEYS.each do |key|
      it "sets the #{key}" do
        Covid19.configure do |config|
          config.send("#{key}=", key)
          expect(Covid19.send(key)).to eq key
        end
      end
    end
  end
end
