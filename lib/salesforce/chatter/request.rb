module Salesforce::Chatter

  module Request
    def get(path, options={}, raw=false)
      request(:get, path, options, raw)
    end

    def post(path, options={}, raw=false)
      request(:post, path, options, raw)
    end

    private

    # Perform an HTTP request
    def request(method, path, options, raw=false)
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
      if path =~ /\/services\/data\/v/
        path
      else
        File.join(chatter_version, path)
      end
    end
  end
end
