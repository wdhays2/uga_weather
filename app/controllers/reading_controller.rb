# frozen_string_literal: true

class ReadingController < ApplicationController
  def show
    @readings = []
    @weather_date = params[:date].to_date - 2.days

    # fetch the data from the database if it exists
    retrieve_from_database
    return @readings unless @readings.empty?

    # otherwise, get it from the website
    retrieve_from_website
    @readings.reject!(&:empty?)
  end

  def retrieve_from_database
    5.times do
      read = WeatherEntry.where(entered_on: @weather_date.strftime('%Y%m%d'))
      return if read.empty?
      @readings << read
      @weather_date += 1.day
    end
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
