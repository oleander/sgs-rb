module SGS
  class Wash
    #
    # @args[:week] Fixnum Optional
    # @args[:username] String
    # @args[:password] Password 
    #
    def initialize(args)
      @week = args[:week] || Date.today.cweek

      @cookies = SGS::Authenticate.new({
        username: args.fetch(:username),
        password: args.fetch(:password)
      }).cookies

      @booking = Struct.new(:group, :start_time, :end_time, :where)
    end

    #
    # @return Array<Booking> A list of bookings
    #
    def bookings
      @_bookings ||= lambda {
        url = %W{
          http://tvatta.sgsstudentbostader.se/wwwashbookings.aspx?
          panelId=616&
          weekoffset=0&
          date=#{URI.escape week_dates(@week).strftime("%Y-%m-%d %H:%M:%S")}
        }.join("")

        RestClient.get("http://www.sgsstudentbostader.se/ext_gw.aspx?module=wwwash&lang=se", cookies: @cookies) do |r|
          RestClient.get(r.headers[:location], cookies: @cookies) do |r|
            return prepare_data(RestClient.get(url, {
              cookies: r.cookies.merge(@cookies)
            }))
          end
        end
      }.call
    end

    private
    def prepare_data(raw)
      tr = Nokogiri::HTML(raw).css(".smallText.headerColor").to_a
      total = (tr.count + 1) / 4

      total.times.map do |n|
        start_time = Time.parse("#{tr[n * 4 + 1].content} #{tr[n * 4 + 3].content.split("-").first}") # 2012-05-31 11:30:00 +0200
        end_time   = Time.parse("#{tr[n * 4 + 1].content} #{tr[n * 4 + 3].content.split("-").last}")  # 2012-05-31 13:00:00 +0200
        group      = tr[n * 4 + 2].content.match(/^\w+: (.+)$/).to_a.last                             # 1
        where      = URI.decode(tr[n * 4].at_css("b").content)                                        # Tvätt 307

        @booking.new(group, start_time, end_time, where)
      end
    end

    def week_dates(week_num)
      Date.commercial(Time.now.year, week_num, 1)
    end
  end
end