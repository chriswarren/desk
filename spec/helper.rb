require 'simplecov'
SimpleCov.start do
  add_group 'Desk', 'lib/desk'
  add_group 'Faraday Middleware', 'lib/faraday'
  add_group 'Specs', 'spec'
end
require 'desk'
require 'pony'
require 'rspec'
require 'webmock/rspec'
require 'email_spec'
require 'ruby-debug'

require 'shared_context'
require 'shared_examples'

RSpec.configure do |config|
  config.include WebMock::API
end

def a_delete(path)
  a_request(:delete, Desk.endpoint + path)
end

def a_get(path)
  a_request(:get, Desk.endpoint + path)
end

def a_patch(path)
  a_request(:patch, Desk.endpoint + path)
end

def a_post(path)
  a_request(:post, Desk.endpoint + path)
end

def a_put(path)
  a_request(:put, Desk.endpoint + path)
end

def stub_delete(path)
  stub_request(:delete, Desk.endpoint + path)
end

def stub_get(path)
  stub_request(:get, Desk.endpoint + path)
end

def stub_patch(path)
  stub_request(:patch, Desk.endpoint + path)
end

def stub_post(path)
  stub_request(:post, Desk.endpoint + path)
end

def stub_put(path)
  stub_request(:put, Desk.endpoint + path)
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end
