require 'helper'

describe Faraday::Response do
  before do
    @client = Assistly::Client.new
  end

  {
    400 => Assistly::BadRequest,
    401 => Assistly::Unauthorized,
    403 => Assistly::Forbidden,
    404 => Assistly::NotFound,
    406 => Assistly::NotAcceptable,
    420 => Assistly::EnhanceYourCalm,
    500 => Assistly::InternalServerError,
    502 => Assistly::BadGateway,
    503 => Assistly::ServiceUnavailable,
  }.each do |status, exception|
    context "when HTTP status is #{status}" do

      before do
        stub_get('users/1.json').
          with(:headers => {'Accept'=>'application/json', 'User-Agent'=>'Assistly Ruby Gem 0.0.1'}).
          to_return(:status => status)
      end

      it "should raise #{exception.name} error" do
        lambda do
          @client.user(1)
        end.should raise_error(exception)
      end
    end
  end
end
