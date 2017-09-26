# frozen_string_literal: true

class ReadingsController < ApplicationController
  def index
    wd = WeatherData.new
    @readings = wd.process
    @read = @readings.values.map { |data| DailyReading.new(data) }
  end

  def create
    @readings = WeatherData.new(params[:readings])
  end

  def show
    # fetch data from weather site
    wd = WeatherData.new
    @readings = wd.process
    @read = @readings.values.map { |data| DailyReading.new(data) }
    # load data into Virtus model
    # render data
  end
end
