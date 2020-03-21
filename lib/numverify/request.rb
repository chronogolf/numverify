# frozen_string_literal: true

require 'numverify/errors/numverify_client_error'
require 'numverify/errors/api_error'
require 'numverify/errors/https_access_restriction_error'
require 'numverify/errors/inactive_user_error'
require 'numverify/errors/invalid_access_key_error'
require 'numverify/errors/invalid_api_function_error'
require 'numverify/errors/invalid_country_code_error'
require 'numverify/errors/no_phone_number_error'
require 'numverify/errors/non_numeric_phone_number_error'
require 'numverify/errors/not_found_error'
require 'numverify/errors/usage_limit_error'
require 'numverify/result'
require 'uri'

module NumverifyClient
  class Request
    def initialize(query: {}, https: false)
      @base_uri   = "#{protocol(https)}://apilayer.net"
      @query      = query
      @path       = '/api/validate'
      @connection = Excon.new(@base_uri)
    end

    attr_reader :connection, :path, :query

    def perform(**args)
      response = connection.request(args.merge(path: path, query: query))
      parsed_response = JSON.parse(response.body)
      if parsed_response.key?('error')
        handle_error(parsed_response['error'])
      else
        NumverifyClient::Result.new(parsed_response)
      end
    end

    private

    def protocol(use_https)
      use_https ? 'https' : 'http'
    end

    def handle_error(error)
      case error['code']
      when 404
        raise NotFoundError, error['info']
      when 101
        raise InvalidAccessKeyError, error['info']
      when 103
        raise InvalidApiFunctionError, error['info']
      when 210
        raise NoPhoneNumberError, error['info']
      when 211
        raise NonNumericPhoneNumberError, error['info']
      when 310
        raise InvalidCountryCodeError, error['info']
      when 104
        raise UsageLimitError, error['info']
      when 105
        raise HttpsAccessRestrictionError, error['info']
      when 102
        raise InactiveUserError, error['info']
      else
        raise APIError, error['info']
      end
    end
  end
end
