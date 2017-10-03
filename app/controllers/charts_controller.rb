# frozen_string_literal: true

class ChartsController < ApplicationController
  def show
    @chart_display = ChartDisplay.new(date: params[:date])

  end
end
