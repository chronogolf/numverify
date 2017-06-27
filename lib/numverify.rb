require 'excon'
require 'json'
require 'numverify/version'
require 'numverify/request'

module NumverifyClient
  class << self
    def validate(number:, country_code: nil, access_key: ENV['NUMVERIFY_ACCESS_KEY'])
      request(build_query(number, country_code, access_key)).perform(method: :get)
    end

    private

    def build_query(number, country_code, access_key)
      {
        number: number,
        country_code: country_code,
        access_key: access_key
      }
    end

    def request(query)
      NumverifyClient::Request.new(query)
    end
  end
end
