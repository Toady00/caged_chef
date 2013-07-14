require 'spec_helper'
require 'caged_chef'

describe CagedChef::ChefAuth do
  let(:key)        { File.expand_path('../../dummy_key.pem', __FILE__) }
  let(:url)        { URI('https://example.chef.com') }

  let(:request_headers)  { faraday.run_request(:get, "#{url}/clients", "", {}).env[:request_headers] }
  let(:required_headers) { %w(X-Ops-Sign X-Ops-Userid X-Ops-Timestamp X-Ops-Content-Hash X-Ops-Authorization-1) }
  let(:expected_headers) { {"X-Ops-Sign"=>"algorithm=sha1;version=1.0;", "X-Ops-Userid"=>"hex", "X-Ops-Timestamp"=>"2013-01-01T17:00:00Z", "X-Ops-Content-Hash"=>"2jmj7l5rSw0yVb/vlWAYkK/YBwk=", "X-Ops-Authorization-1"=>"f1Hz2UDpsXLLh0T06274A86ka4NmcWl51Irjwb47Xr6bDnBaZcfx4l9mhdBP", "X-Ops-Authorization-2"=>"KAjDM5wQBDU/xkFewO+VAq4DUHNx/qvjEJGeAqSLK8dLMGOR35mJkNZIz3sb", "X-Ops-Authorization-3"=>"DTxlX0fHNNriAYt/oZcWqIIqI+V0oP+ReEvtnLQRuxM2yWpctFuOJytxcSnV", "X-Ops-Authorization-4"=>"NCmTpO/35dWquOLl91PVcYgStki9tFvYXH4Hc9bvlCUjYwxB3BgELrS7Ovk1", "X-Ops-Authorization-5"=>"8fw3kgGYpyeke5kY8z7w1p10qyCvEVZCSxDBUta9owWGau6pc38TvD8mymH7", "X-Ops-Authorization-6"=>"LzU34mUiDgKV8O9hGowJFsHNiYDMolSBaM3PVdjhVw=="} }

  before(:each) do
    time = Time.new(2013, 1, 1, 12, 0, 0, "+05:00")
    Timecop.freeze(time)

    @chef_auth_options = {
      key: key,
      host: url,
      user_id: 'hex'
    }
  end

  after { Timecop.return }

  let(:faraday) do
    Faraday.new(url: url) do |f|
      f.request :caged_chef, @chef_auth_options
    end
  end

  subject { request_headers }

  it "contains the required headers" do
    required_headers.each do |header_key|
      request_headers.should have_key header_key
    end
  end

  it "sets mixlib_auth headers" do
    required_headers.each do |header_key|
      request_headers[header_key].should_not be_empty
    end
  end

  it "has the expected values for each header" do
    expected_headers.each do |header, value|
      request_headers[header].should eq value
    end
  end
end
