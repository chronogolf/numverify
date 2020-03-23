# frozen_string_literal: true

require 'excon'
require 'json'
require 'numverify/version'
require 'numverify/configuration'
require 'numverify/request'

module NumverifyClient
  class << self
    attr_accessor :configuration

    def configure
      self.configuration ||= Configuration.new
      yield configuration
    end

    def validate(number:, country_code: nil)
      request(build_query(number, country_code, access_key)).perform(method: :get)
    end

    private

    def access_key
      configuration.access_key || ENV['NUMVERIFY_ACCESS_KEY']
    end

    def build_query(number, country_code, access_key)
      {
        number: number,
        country_code: country_code,
        access_key: access_key
      }
    end

    def request(query)
      NumverifyClient::Request.new(query: query, https: configuration.https)
    end
  end
end
