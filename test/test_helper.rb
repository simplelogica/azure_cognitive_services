require 'minitest/autorun'
require 'minitest-vcr'
require 'webmock'

VCR.configure do |c|
  c.cassette_library_dir = 'test/cassettes'
  c.hook_into :webmock
  c.filter_sensitive_data('<VISION_API_KEY>') { ENV["VISION_API_KEY"] }
  c.filter_sensitive_data('<TRANSLATOR_API_KEY>') { ENV["TRANSLATOR_API_KEY"] }
end

MinitestVcr::Spec.configure!
