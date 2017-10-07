# frozen_string_literal: true

class ReadingsController < ApplicationController
  def show
    @readings = GatherReadings.process(date: params[:date])
  end
end
