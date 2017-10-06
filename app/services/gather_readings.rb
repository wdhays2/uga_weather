class GatherReadings
  def self.process(options)
    obj = new(options)
    obj.run
  end

  def initialize(options)
    @readings = []
    weather_date = Date.parse(options[:date] || '2017-01-01')
    @start_date = weather_date - 2.days
    @end_date = weather_date + 2.days
  end

  def run
    # fetch the data from the database if it exists
    retrieve_from_database
binding.pry
    return @readings unless @readings.size < 5

    # otherwise, get it from the website
    retrieve_from_website
    @readings.reject!(&:empty?)
  end

  def retrieve_from_database
    @readings = WeatherEntry.select(:name, :min_reading, :max_reading)
                            .where('entered_on between ? AND ?', @start_date, @end_date)
                            .order(entered_on: :asc)
                            .group(:entered_on)
                            .map { |row| {row.name => [row.min_reading, row.max_reading]} }
  end

  def retrieve_from_website
    5.times do
      wd = WeatherData.new(@weather_date.strftime('%Y%m%d'))
      readings = wd.process
      read = readings.values.map { |data| Reading.new(data) }
      @readings << read
      @weather_date += 1.day
    end
  end
end