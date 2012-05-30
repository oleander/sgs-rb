require "rspec"
require "webmock"
require "sgs"
require "vcr"

$username = `echo $U`.strip
$password = `echo $P`.strip

RSpec.configure do |config|
  config.mock_with :rspec
  config.extend VCR::RSpec::Macros
end

VCR.configure do |c|
  c.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  c.hook_into :webmock
  c.default_cassette_options = {
    record: :new_episodes
  }
  c.filter_sensitive_data("<password>") { $password }
  c.filter_sensitive_data("<username>") { $username }
  c.allow_http_connections_when_no_cassette = false
end