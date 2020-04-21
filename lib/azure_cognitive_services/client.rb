require 'net/http'
require 'uri'
require 'json'

module AzureCognitiveServices
  class Client
    def initialize(service_uri:, api_key:)
      @service_uri = service_uri
      @api_key = api_key
    end

    def make_request(query:, body:)
      @service_uri.query = URI.encode_www_form(query)
      request = Net::HTTP::Post.new(@service_uri.request_uri)
      request['Ocp-Apim-Subscription-Key'] = @api_key
      request['Content-Type'] = 'application/json'
      request.body = body

      response = Net::HTTP.start(@service_uri.host,
                                 @service_uri.port,
                                 use_ssl: @service_uri.scheme == 'https') do |http|
        http.request(request)
      end
      parse_response(response.body)
    end

    private

    def check_for_errors_in(response)
      return if !response.is_a?(Hash) || (response.is_a?(Hash) && response['error'].nil?)

      raise(ApiError, "#{response['error']['code']} - #{response['error']['message']}")
    end

    def parse_response(response_body)
      parsed_response = JSON.parse(response_body)
      check_for_errors_in(parsed_response)
      parsed_response
    end
  end
end
