module Desk
  # Defines HTTP request methods
  module Request
    require 'json' unless defined?(::JSON)
    REQUEST_METHODS = [
      'get',
      'patch',
      'post',
      'put',
      'delete'
    ].freeze

    def method_missing(method_name, *args, &block)
      if (REQUEST_METHODS.include? method_name.to_s) && (args.length > 0)
        path = args[0]
        options = args[1] ? args[1] : {}
        raw = args[2] ? args[2] : false
        request(method_name.to_sym, path, options, raw)
      else
        super
      end
    end

    def respond_to?(method_name, include_private = false)
      if (REQUEST_METHODS.include? method_name.to_s)
        true
      else
        super
      end
    end

    private

    def before_request
      if Desk.minute != Time.now.min
        Desk.minute = Time.now.min
        Desk.counter = 0
      end

      Desk.counter += 1
      if Desk.use_max_requests
        if Desk.counter > Desk.max_requests
          raise Desk::TooManyRequests
        end
      end
    end

    # Perform an HTTP request
    def request(method, path, options, raw=false)
      before_request
      response = connection(raw).send(method) do |request|
        case method
        when :get, :delete
          request.url(formatted_path(path), options)
        when :post, :put
          request.path = formatted_path(path)
          request.headers['Content-Type'] = 'application/json'
          request.body = options.to_json unless options.empty?
        end
      end
      raw ? response : response.body
    end

    def formatted_path(path)
      if(self.version == "v1")
        [path, format].compact.join('.')
      else
        path
      end
    end
  end
end
