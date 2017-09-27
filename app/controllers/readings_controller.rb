# frozen_string_literal: true

class ReadingsController < ApplicationController

  def show
    # fetch data from weather site
    wd = WeatherData.new(params[:date])
    @readings = wd.process
    @read = @readings.values.map { |data| Reading.new(data) }
    # load data into Virtus model
    # render data
  end
end
