class ChartDisplay
  def self.process(options)
    obj = new(options)
    obj.run
  end

  def initialize(options)
    weather_date = Date.parse(options[:date] || '2017-01-01')
    @start_date = weather_date - 2.days
    @end_date = weather_date + 2.days
  end

  # [
  #   {
  #     section: 'Wind Direction',
  #     dates: ['20170928',...],
  #     tooltip: ' Degrees',
  #     values: [
  #       [40, 60],
  #       ...
  #     ]
  #   }
  #   ...
  # ]

  def run
    date_range = (@start_date..@end_date).map { |date| date.to_s.delete('-') }
    categories.map do |category|
      {
        section: category,
        date_range: date_range,
        tooltip: tooltip_value(category),
        values: min_max_query_for_range(category)
      }
    end
  end

  private

  def categories
    [
      'Wind Direction', 'Wind Speed', 'Humidity', 'Out Temp',
      'Raw Barometer', 'UV Index', 'Solar Radiation',
      'Wind Chill', 'Out Heat Ix', 'Dew Point'
    ]
  end

  def tooltip_value(key)
    return if ['Solar Radiation', 'Raw Barometer', 'UV Index'].include?(key)
    case key
    when 'Wind Speed' then ' MPH'
    when 'Wind Direction' then ' Degrees'
    when 'Humidity' then '%'
    else '°F'
    end
  end

  def min_max_query_for_range(category)
    WeatherEntry.select(:min_reading, :max_reading)
                .where(name: category)
                .where('entered_on between ? AND ?', @start_date, @end_date)
                .order(entered_on: :asc)
                .map { |row| [row.min_reading, row.max_reading] }
  end
end
