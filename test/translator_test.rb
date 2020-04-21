require 'azure_cognitive_services'
require_relative 'test_helper'

describe AzureCognitiveServices do
  describe AzureCognitiveServices::Translator do
    it 'must be initialized with an api key' do
      proc { AzureCognitiveServices::Translator.new }.must_raise ArgumentError
    end

    describe '#translate', :vcr do
      before do
        @service = AzureCognitiveServices::Translator.new api_key: ENV['TRANSLATOR_API_KEY']
      end

      it 'must translate a simple phrase from english to spanish' do
        response = @service.translate('I am too old for this', from: :en, to: :es)

        response.must_be_kind_of Array
        response.first.keys.wont_include 'error'
        response.first.keys.must_include 'translations'
        response.first['translations'].must_be_kind_of Array
        response.first['translations'].size.must_equal 1
        response.first['translations'].first['to'].must_equal 'es'
      end

      it 'must translate a simple phrase from english to spanish and italian' do
        response = @service.translate('I am too old for this', from: :en, to: [:es, :it])

        response.must_be_kind_of Array
        response.first.keys.wont_include 'error'
        response.first.keys.must_include 'translations'
        response.first['translations'].must_be_kind_of Array
        response.first['translations'].size.must_equal 2
        response.first['translations'].map { |translation| translation['to'] }.must_include 'es'
        response.first['translations'].map { |translation| translation['to'] }.must_include 'it'
      end

      it 'must raise an exception when translation for an unsuported language is solicited' do
        proc do
          @service.translate('I am too old for this', from: :en, to: [:es, :lu])
        end.must_raise AzureCognitiveServices::ApiError
      end
    end
  end
end
