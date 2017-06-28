require 'spec_helper'

module NumverifyClient
  describe Request do
    context 'perform' do
      context 'when all params are valid' do
        let(:response) do
          VCR.use_cassette('validate/valid_request') do
            described_class.new(build_test_query).perform(method: :get)
          end
        end

        it 'responds with a result object' do
          expect(response).to be_a(NumverifyClient::Result)
        end

        it 'returns a valid object' do
          expect(response.valid).to eq true
        end
      end

      context 'when an error occurs' do
        it 'raises an error when the access key is missing' do
          VCR.use_cassette('validate/invalid_access_key_error') do
            expect do
              described_class.new(build_test_query.merge(access_key: nil)).perform(method: :get)
            end.to raise_error(NumverifyClient::InvalidAccessKeyError)
          end
        end

        it 'raises an error when the country code is not valid' do
          VCR.use_cassette('validate/invalid_country_code_error') do
            expect do
              described_class.new(build_test_query.merge(country_code: 'ABCD')).perform(method: :get)
            end.to raise_error(NumverifyClient::InvalidCountryCodeError)
          end
        end

        it 'raises an error when the phone number is missing' do
          VCR.use_cassette('validate/no_phone_number_error') do
            expect do
              described_class.new(build_test_query.merge(number: nil)).perform(method: :get)
            end.to raise_error(NumverifyClient::NoPhoneNumberError)
          end
        end

        it 'raises an error when the phone number is not a numeric value' do
          VCR.use_cassette('validate/non_numeric_phone_number_error') do
            expect do
              described_class.new(build_test_query.merge(number: 'ABCDE')).perform(method: :get)
            end.to raise_error(NumverifyClient::NonNumericPhoneNumberError)
          end
        end

        it 'raises an error when the phone number is not found' do
          VCR.use_cassette('validate/not_found_error') do
            expect do
              described_class.new(build_test_query).perform(method: :get)
            end.to raise_error(NumverifyClient::NotFoundError)
          end
        end

        it 'raises an error when API usage reached its limit' do
          VCR.use_cassette('validate/usage_limit_error') do
            expect do
              described_class.new(build_test_query).perform(method: :get)
            end.to raise_error(NumverifyClient::UsageLimitError)
          end
        end

        it 'raises an error when HTTPS usage is forbidden' do
          VCR.use_cassette('validate/https_access_restriction_error') do
            expect do
              described_class.new(build_test_query).perform(method: :get)
            end.to raise_error(NumverifyClient::HttpsAccessRestrictionError)
          end
        end

        it 'raises an error when API user is inactive' do
          VCR.use_cassette('validate/inactive_user_error') do
            expect do
              described_class.new(build_test_query).perform(method: :get)
            end.to raise_error(NumverifyClient::InactiveUserError)
          end
        end

        it 'raises an error when the function is not valid' do
          VCR.use_cassette('validate/invalid_api_function_error') do
            expect do
              described_class.new(build_test_query).perform(method: :get)
            end.to raise_error(NumverifyClient::InvalidApiFunctionError)
          end
        end

        it 'raises an API error when error returned is not known' do
          VCR.use_cassette('validate/api_error') do
            expect do
              described_class.new(build_test_query).perform(method: :get)
            end.to raise_error(NumverifyClient::APIError)
          end
        end
      end
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
