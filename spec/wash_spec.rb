# -*- encoding : utf-8 -*-
describe SGS::Wash do
  use_vcr_cassette "wash"

  it "should return a list of bookings for this week" do
    bookings = SGS::Wash.new({
      username: $username,
      password: $password
    }).bookings

    bookings.count.should eq(2)
    booking = bookings.last
    booking.group.should eq("1")
    booking.start_time.to_s.should eq("2012-06-05 10:00:00 +0200")
    booking.end_time.to_s.should eq("2012-06-05 11:30:00 +0200")
    booking.where.should eq("Tvätt 307")
  end

  it "should be possible to pass a week" do
    bookings = SGS::Wash.new({
      username: $username,
      password: $password,
      week: 23 # Next week
    }).bookings

    bookings.count.should eq(2)
  end
end