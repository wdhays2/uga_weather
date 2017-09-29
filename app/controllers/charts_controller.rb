# frozen_string_literal: true

class ChartsController < ApplicationController
  def show
    categories
    empty_arrays
    params[:date] ||= '2017-01-01'
    weather_date = params[:date].to_date - 2.days
    @date_range = collect_for_date_range(weather_date)
    @data = put_it_all_together(combine_data_variables)
  end

  def categories
    @categories = ['Wind Direction', 'Wind Speed', 'Humidity', 'Out Temp',
                   'Raw Barometer', 'UV Index', 'Solar Radiation',
                   'Wind Chill', 'Out Heat Ix', 'Dew Point']
  end

  def empty_arrays
    @wind_dir_range = []
    @wind_spd_range = []
    @humidity_range = []
    @temp_range = []
    @barometer_range = []
    more_arrays
  end

  def more_arrays
    @uv_range = []
    @radiation_range = []
    @wind_chill_range = []
    @heat_index_range = []
    @dew_point_range = []
  end

  def collect_for_date_range(weather_date)
    (weather_date...weather_date + 5.days).map do |date|
      populate_instance_variables(date)
      date.to_s.delete('-')
    end
  end

  def combine_data_variables
    arrays = []
    arrays << @wind_dir_range
    arrays << @wind_spd_range
    arrays << @humidity_range
    arrays << @temp_range
    arrays << @barometer_range
    combine_more(arrays)
  end

  def combine_more(arrays)
    arrays << @uv_range
    arrays << @radiation_range
    arrays << @wind_chill_range
    arrays << @heat_index_range
    arrays << @dew_point_range
  end

  def put_it_all_together(combine_data_variables)
    data = {}
    @categories.each_with_index do |cat, indx|
      data[cat] = combine_data_variables[indx]
    end
    data
  end

  def populate_instance_variables(date)
    @wind_dir_range << data_collector(date, @categories[0])
    @wind_spd_range << data_collector(date, @categories[1])
    @humidity_range << data_collector(date, @categories[2])
    some_more(date)
  end

  def some_more(date)
    @temp_range << data_collector(date, @categories[3])
    @barometer_range << data_collector(date, @categories[4])
    @uv_range << data_collector(date, @categories[5])
    the_rest(date)
  end

  def the_rest(date)
    @radiation_range << data_collector(date, @categories[6])
    @wind_chill_range << data_collector(date, @categories[7])
    @heat_index_range << data_collector(date, @categories[8])
    @dew_point_range << data_collector(date, @categories[9])
  end

  def data_collector(date, category)
    combine = []
    combine << WeatherEntry.where(entered_on: date.strftime('%Y%m%d'))
               .where(name: category).select(:min_reading).pluck(:min_reading)
               .first

    combine << WeatherEntry.where(entered_on: date.strftime('%Y%m%d'))
               .where(name: category).select(:max_reading).pluck(:max_reading)
               .first
  end
end
