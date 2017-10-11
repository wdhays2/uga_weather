# frozen_string_literal: true

class ImportWeather
  def initialize(date)
    # enter a date as a string: '20140115'
    # Five days for 2014 will be stored into the database when imported.
    @date = date.to_date
  end

  def weather_import
    5.times do
      wd = WeatherData.new(@date.strftime('%Y%m%d'))
      readings = wd.process
      readings.map do |_key, data|
        WeatherEntry.create(data)
      end
      return if @date >= @date.end_of_year
      return if @date >= Date.today - 1.day
      @date += 1.day
    end
  end
end
