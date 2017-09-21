class ReadingsController < ApplicationController
  def index
    @readings = WeatherData.new
    @readings.process
  end

  def create
    @readings = WeatherData.new(params[:readings])
  end

  def show
    # fetch data from weather site
    # load data into Virtus model
    # render data
  end
end
