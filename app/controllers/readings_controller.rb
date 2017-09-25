# frozen_string_literal: true

class ReadingsController < ApplicationController
  def index
    @readings = WeatherData.new
    @results = @readings.process
  end

  def create
    @readings = WeatherData.new(params[:readings])
  end

  def show
    # fetch data from weather site
    @readings = WeatherData.new
    @results = @readings.process
    # load data into Virtus model
    # render data
  end
end
