# frozen_string_literal: true

class ResultsController < ApplicationController
  def show
    ctgory = params[:category] || 'Out Temp'
    @results = GatherResults.process(date: params[:date])
    @chart_display = ChartDisplay.process(date: params[:date], category: ctgory)
  end
end
