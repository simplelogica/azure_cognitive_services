module AzureCognitiveServices
  class ComputerVision < Client
    SERVICE_URI = URI('https://westeurope.api.cognitive.microsoft.com/vision/v2.0/analyze')

    def initialize(api_key:)
      super(service_uri: SERVICE_URI, api_key: api_key)
    end

    def analyze_image(url:, visual_features: 'Description', details: '', language: :en)
      raise(ArgumentError, 'Invalid image URL') unless url =~ URI::DEFAULT_PARSER.regexp[:ABS_URI]

      make_request query: { 'visualFeatures' => visual_features,
                            'details' => details,
                            'Language' => language },
                   body: { url: url }.to_json
    end

    private

    def check_for_errors_in(response)
      return if response.is_a?(Hash) && response['code'].nil? && response['message'].nil?

      raise(ApiError, "#{response['code']} - #{response['message']}")
    end
  end
end
