# CagedChef

CagedChef is a middleware for Faraday. 

## Installation

Add this line to your application's Gemfile:

    gem 'caged_chef'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install caged_chef

## Usage

````ruby
url = 'https://example.chef.com'

chef_auth_options = {
  key: '/path/to/client/private/key',
  host: url,
  user_id: 'your-chef-user-id'
}

faraday = Faraday.new(url: url) do |faraday|
  faraday.request :caged_chef, chef_auth_options
  # other faraday settings
end

response = faraday.run_request('http_method', "#{url}/some/path", "body", {})
````

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
