module Desk
  # Defines HTTP request methods
  module Request
    # Perform an HTTP GET request
    def get(path, options={}, raw=false)
      request(:get, path, options, raw)
    end

    # Perform an HTTP POST request
    def post(path, options={}, raw=false)
      request(:post, path, options, raw)
    end

    # Perform an HTTP PUT request
    def put(path, options={}, raw=false)
      request(:put, path, options, raw)
    end

    # Perform an HTTP DELETE request
    def delete(path, options={}, raw=false)
      request(:delete, path, options, raw)
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
          request.body = options unless options.empty?
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
