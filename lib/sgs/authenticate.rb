module SGS
    class Authenticate
    #
    # @args[:password] String
    # @args[:username] String
    #
    def initialize(args)
      @username, @password = args.fetch(:username), args.fetch(:password)
    end

    #
    # @return Hash Cookies used by SGS
    #
    def cookies
      @_cookies ||= lambda {
        url = %W{
          http://marknad.sgsstudentbostader.se/s3.aspx?
          page=pgRedirect&
          verifylogin=y&
          mg=1&
          id=/se/mina-sidor&
          client=#{@username}&
          pin=#{@password}&
          url=http://www.sgsstudentbostader.se/setlogin.aspx
        }.join("")

        RestClient.get(url) do |r1|
          if r1.headers[:location] =~ /blnInloggadFull=false/
            raise NotAuthorisedError.new("Invalid username of password")
          end
          RestClient.get(r1.headers[:location]) do |r2|
            return r2.cookies
          end
        end
      }.call
    end
  end
end