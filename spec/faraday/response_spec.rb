require 'helper'

describe Faraday::Response do
  before do
    @client = Desk::Client.new
  end

  {
    400 => Desk::BadRequest,
    401 => Desk::Unauthorized,
    403 => Desk::Forbidden,
    404 => Desk::NotFound,
    406 => Desk::NotAcceptable,
    429 => Desk::EnhanceYourCalm,
    500 => Desk::InternalServerError,
    502 => Desk::BadGateway,
    503 => Desk::ServiceUnavailable,
  }.each do |status, exception|
    context "when HTTP status is #{status}" do

      before do
        stub_get('users/1').
          with(:headers => {'Accept'=>'application/json', 'User-Agent'=>Desk::Configuration::DEFAULT_USER_AGENT}).
          to_return(:status => status)
      end

      it { expect{ @client.user(1) }.to raise_error(exception) }

    end
  end
end
