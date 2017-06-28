require 'spec_helper'

module NumverifyClient
  describe Result do
    let(:response) do
      VCR.use_cassette('validate/valid_request') do
        NumverifyClient::Request.new(build_test_query).perform(method: :get)
      end
    end

    it 'responds with a result object' do
      expect(response).to be_a(NumverifyClient::Result)
    end

    it 'returns the phone validity' do
      expect(response.valid).to eq true
    end

    it 'returns number with the country number' do
      expect(response.number).to eq '14158586273'
    end

    it 'returns number with the country number' do
      expect(response.international_format).to eq '+14158586273'
    end

    it 'returns the country prefix' do
      expect(response.country_prefix).to eq '+1'
    end

    it 'returns the country code' do
      expect(response.country_code).to eq 'US'
    end

    it 'returns the country code' do
      expect(response.country_name).to eq 'United States of America'
    end

    it 'returns the location' do
      expect(response.location).to eq 'Novato'
    end

    it 'returns the carrier' do
      expect(response.carrier).to eq 'AT&T Mobility LLC'
    end

    it 'returns the line type' do
      expect(response.line_type).to eq 'mobile'
    end

    private

    def build_test_query
      {
        number: 4_158_586_273,
        country_code: 'US',
        access_key: 'test_access_key'
      }
    end
  end
end
