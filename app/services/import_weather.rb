# frozen_string_literal: true

class ImportWeather
  def initialize(date)
    # enter a date as a string: '2014-01-01'
    # The whole year for 2014 will be stored into the database when imported.
    @date = date.to_date.beginning_of_year
  end

  def mass_import
    366.times do
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
