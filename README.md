# SGS

Ruby wrapper for [sgsstudentbostader.se](http://www.sgsstudentbostader.se).

## Installation

`[sudo] gem install sgs`

## Usage

### Wash

``` ruby
booking = SGS::Wash.new({
  username: "username",
  password: "secret"
}).bookings.first

booking.group # => "2"
```

### Booking

- **group** (String) What group was booked?
- **start_time** (Time) When does it start?
- **end_time** (Time) When does it end?
- **where** (String) What studio was booked?

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Requirements

*SGS* is tested in *OS X 10.7.4* using Ruby *1.9.2*.

## License

*SGS* is released under the *MIT license*.