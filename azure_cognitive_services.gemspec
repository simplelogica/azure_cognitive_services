Gem::Specification.new do |s|
  s.name         = 'azure_cognitive_services'
  s.version      = '0.0.0'
  s.date         = '2020-04-13'
  s.summary      = 'A simple ruby library to interact with Azure Cognitive Services REST API'
  s.description  = 'A simple ruby library to interact with Azure Cognitive Services REST API'
  s.authors      = ['The Cocktail']
  s.email        = 'antonio.rossi@the-cocktail.com'
  s.files        = `git ls-files`.split($RS)
  s.test_files   = s.files.grep(%r{^(test)/})
  s.homepage     = 'https://rubygems.org/gems/azure-cognitive-services'
  s.license      = 'MIT'
  s.require_path = 'lib'
  s.add_development_dependency 'minitest',     ['>= 0']
  s.add_development_dependency 'minitest-vcr', ['>= 0']
  s.add_development_dependency 'rubocop',      ['>= 0']
end
