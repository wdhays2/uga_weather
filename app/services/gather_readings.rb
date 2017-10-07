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
    return @readings unless @readings.size != 5

    # otherwise, get it from the website
    retrieve_from_website
    @readings.reject!(&:empty?)
  end

  def retrieve_from_database
    ids = WeatherEntry.select(:id)
                            .where('entered_on between ? AND ?', @start_date, @end_date)
                            .order(entered_on: :asc)
                            .pluck(:id)
    readings = ids.map { |id| WeatherEntry.find(id) }
    method_name(readings)
  end

  def method_name(readings)
    day = @start_date
    days_readings = []
    5.times do
      readings.each do |reading|
        if reading.entered_on == day
          days_readings << reading
        end
      end
      day += 1.day
      @readings << days_readings
      days_readings = []
    end
    @readings.reject!(&:empty?)
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