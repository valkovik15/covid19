# frozen_string_literal: true

RSpec.describe Covid19::Request do
  context 'when API key is provided' do
    before do
      Covid19.configure do |config|
        config.key = 'random-key'
      end
    end

    after do
      Covid19.reset
    end

    describe '#get with 404 status' do
      before do
        stub_get('/totals')
          .to_return(body: 'Not found', status: 404)
      end

      it 'raises a Covid19::NotFoundError' do
        expect { Covid19.world_totals }.to raise_error(Covid19::NotFoundError)
      end
    end

    describe '#get with a non-200 status' do
      before do
        stub_get('/totals')
          .to_return(body: 'Server error', status: 500)
      end

      it 'raises a Covid19::Error' do
        expect { Covid19.world_totals }.to raise_error(Covid19::APICallError)
      end
    end

    describe 'request behind proxy' do
      before do
        allow(ENV).to receive(:[]).with('no_proxy').and_return('')
        allow(ENV).to receive(:[]).with('https_proxy').and_return('http://proxy_user:proxy_pass@192.168.1.99:9999')
        stub_get('/totals')
          .to_return(body: fixture('latest_world.json'))
      end

      it 'can be made' do
        client = Covid19.new
        client.world_totals
        connection = client.instance_variable_get(:@connection)
        expect(connection.proxy_address).to eq '192.168.1.99'
        expect(connection.proxy_user).to eq 'proxy_user'
        expect(connection.proxy_pass).to eq 'proxy_pass'
        expect(connection.proxy_port).to eq 9999
      end
    end
  end

  context 'when API key is not provided' do
    before do
      stub_get('/totals').to_return(body: fixture('latest_world.json'))
    end
    it 'raises a Covid19:::APIKeyError' do
      expect { Covid19.world_totals }.to raise_error(Covid19::APIKeyError)
    end
  end
end
