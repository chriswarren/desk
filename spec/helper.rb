require 'simplecov'
SimpleCov.start do
  add_group 'Assistly', 'lib/assistly'
  add_group 'Faraday Middleware', 'lib/faraday'
  add_group 'Specs', 'spec'
end
require 'assistly'
require 'rspec'
require 'webmock/rspec'
require 'ruby-debug'
RSpec.configure do |config|
  config.include WebMock::API
end

def a_delete(path)
  a_request(:delete, Assistly.endpoint + path)
end

def a_get(path)
  a_request(:get, Assistly.endpoint + path)
end

def a_post(path)
  a_request(:post, Assistly.endpoint + path)
end

def a_put(path)
  a_request(:put, Assistly.endpoint + path)
end

def stub_delete(path)
  stub_request(:delete, Assistly.endpoint + path)
end

def stub_get(path)
  stub_request(:get, Assistly.endpoint + path)
end

def stub_post(path)
  stub_request(:post, Assistly.endpoint + path)
end

def stub_put(path)
  stub_request(:put, Assistly.endpoint + path)
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end
