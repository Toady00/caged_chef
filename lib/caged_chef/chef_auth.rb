require 'mixlib/authentication/signedheaderauth'
require 'openSSL'
require 'faraday'

module CagedChef
  class ChefAuth < Faraday::Middleware

    def initialize(app, options = {})
      super(app)

      @app     = app
      @options = options
      @key     = @options[:key]
    end

    def call(env)
      @env = env
      @env[:request_headers] = signed_headers
      @app.call @env
    end

  private
    def mixlib_headers
      {
        http_method: @env[:method],
        path: @env[:url].request_uri,
        body: @env[:body],
        host: @options[:host],
        user_id: @options[:user_id],
        timestamp: Time.now.utc.to_s
      }
    end

    def key
      OpenSSL::PKey::RSA.new(File.read(@key))
    end

    def signing_object
      Mixlib::Authentication::SignedHeaderAuth.signing_object(mixlib_headers)
    end

    def signed_headers
      signing_object.sign key
    end
  end
end
