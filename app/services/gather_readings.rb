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
    return @readings if @readings.size < 5

    # otherwise, get it from the website
    retrieve_from_website
    @readings.reject!(&:empty?)
    @readings
  end

  def retrieve_from_database
    ids = WeatherEntry.select(:id)
                      .where('entered_on between ? AND ?', @start_date, @end_date)
                      .order(entered_on: :asc)
                      .pluck(:id)
    r = ids.map { |id| WeatherEntry.find(id) }
    method_name(r)
  end

  def method_name(r)
    day = @start_date
    5.times do
      days_readings = []
      r.each { |reading| days_readings << reading if reading.entered_on == day }
      return if days_readings.empty?
      @readings << days_readings
      day += 1.day
    end
  end

  def retrieve_from_website
    (@start_date..@end_date).each do |date|
      wd = WeatherData.new(date.strftime('%Y%m%d'))
      readings = wd.process
      read = readings.values.map { |data| Reading.new(data) }
      @readings << read
    end
  end
end
