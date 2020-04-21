module AzureCognitiveServices
  class Translator < Client
    SERVICE_URI = URI('https://api.cognitive.microsofttranslator.com/translate')

    def initialize(api_key:)
      super(service_uri: SERVICE_URI, api_key: api_key)
    end

    def translate(phrase, from: :en, to:)
      make_request query: { 'api-version' => '3.0', from: from, to: to },
                   body: [{ 'Text' => phrase }].to_json
    end
  end
end
