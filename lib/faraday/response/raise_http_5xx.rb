require 'faraday'

# @private
module Faraday
  # @private
  class Response::RaiseHttp5xx < Response::Middleware
    def on_complete(env)
      case env[:status].to_i
      when 500
        raise Desk::InternalServerError.new(error_message(env, "Something is technically wrong."), env[:response_headers])
      when 501
        raise Desk::NotImplemented.new(error_message(env, "Not implemented."), env[:response_headers])
      when 502
        raise Desk::BadGateway.new(error_message(env, "Desk.com is down or being upgraded."), env[:response_headers])
      when 503
        raise Desk::ServiceUnavailable.new(error_message(env, "(__-){ Desk.com is over capacity."), env[:response_headers])
      end
    end

    private

    def error_message(env, body=nil)
      "#{env[:method].to_s.upcase} #{env[:url].to_s}: #{[env[:status].to_s + ':', body].compact.join(' ')} Check http://desk.com/ for updates on the status of the Desk.com service."
    end
  end
end
