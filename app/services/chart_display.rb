# frozen_string_literal: true

class ChartDisplay
  include ResultsHelper

  def self.process(options)
    obj = new(options)
    obj.run
  end

  def initialize(options)
    @options = options
    readings_date(options)
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
    @date_range = (@start_date..@end_date).map { |date| date.to_s.delete('-') }
    retrieve_from_website_and_store_in_database unless db_has_5_days_of_data?
    @options[:category].nil? ? my_categories : one_category(@options[:category])
  end

  def my_categories
    categories.map do |category|
      {
        section: category,
        date_range: @date_range,
        tooltip: tooltip_value(category),
        values: min_max_query_for_range(category)
      }
    end
  end

  def one_category(category)
    {
      section: category,
      date_range: @date_range,
      tooltip: tooltip_value(category),
      values: min_max_query_for_range(category)
    }
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
