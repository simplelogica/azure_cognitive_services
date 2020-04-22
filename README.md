# Azure Cognitive Services
Basic gem to interact with Azure cognitive services via REST API

## Supported services
* [Computer vision](https://docs.microsoft.com/es-es/azure/cognitive-services/computer-vision/)
* [Translator text](https://docs.microsoft.com/es-es/azure/cognitive-services/translator/)

## Use example
### Computer vision
```ruby
service = AzureCognitiveServices::ComputerVision.new(api_key: 'API_KEY')
service.analyze_image(url: 'https://upload.wikimedia.org/wikipedia/commons/e/e5/Hotel_Puente_Romano.jpg')
```

### Translator text
```ruby
service = AzureCognitiveServices::Translator.new(api_key: 'API_KEY')
service.translate('I am too old for this', from: :en, to: [:es, :pt, :it])
```
