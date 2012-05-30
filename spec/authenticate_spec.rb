describe SGS::Authenticate do
  use_vcr_cassette "authenticate"

  it "should generate proper cookies" do
    cookies = SGS::Authenticate.new({
      username: $username,
      password: $password
    }).cookies

    cookies.keys.should include("ASP.NET_SessionId")
    cookies["ASP.NET_SessionId"].should match(/[a-z0-9]+/)
  end
end