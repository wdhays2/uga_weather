# frozen_string_literal: true

class ReadingsController < ApplicationController
  def show
    @readings = []
    weather_date = params[:date].to_date - 2.days

    # fetch the data from the database if it exists
    5.times do
      @read = WeatherEntry.where(entered_on: weather_date.strftime('%Y%m%d'))
      @readings << @read
      weather_date += 1.day
    end
    @readings.reject!(&:empty?)
    return @readings unless @readings[0].empty?

    # otherwise, get it from the website
    @readings = []
    5.times do
      wd = WeatherData.new(weather_date.strftime('%Y%m%d'))
      readings = wd.process
      @read = readings.values.map { |data| Reading.new(data) }
      @readings << @read
      weather_date += 1.day
    end
    @readings.reject!(&:empty?)
  end
end
