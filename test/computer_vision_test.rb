require 'azure_cognitive_services'
require_relative 'test_helper'

IMAGE_URL = 'https://upload.wikimedia.org/wikipedia/commons/e/e5/Hotel_Puente_Romano.jpg'.freeze

describe AzureCognitiveServices do
  describe AzureCognitiveServices::ComputerVision do
    it 'must be initialized with an api key' do
      proc { AzureCognitiveServices::ComputerVision.new }.must_raise ArgumentError
    end

    describe '#analyze', :vcr do
      it 'must return an exception if image url is invalid' do
        service = AzureCognitiveServices::ComputerVision.new api_key: ENV['VISION_API_KEY']
        proc do
          service.analyze_image(url: 'invalid_url')
        end.must_raise ArgumentError
      end

      it 'must return a valid response hash with a valid image url' do
        service = AzureCognitiveServices::ComputerVision.new api_key: ENV['VISION_API_KEY']

        response = service.analyze_image(url: IMAGE_URL)

        response.must_be_kind_of Hash
        response.keys.must_include 'description'
        response['description'].keys.must_include 'captions'
      end

      it 'must raise an error if a non image url is used' do
        service = AzureCognitiveServices::ComputerVision.new api_key: ENV['VISION_API_KEY']

        proc do
          service.analyze_image(url: 'https://en.wikipedia.org/wiki/Main_Page')
        end.must_raise AzureCognitiveServices::ApiError
      end
    end
  end
end
