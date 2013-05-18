require 'faraday'
require 'caged_chef/version'

module CagedChef
  autoload :ChefAuth, 'caged_chef/chef_auth'

  if Faraday.respond_to? :register_middleware
    Faraday.register_middleware :request, :caged_chef => lambda { ChefAuth }
  end
end
