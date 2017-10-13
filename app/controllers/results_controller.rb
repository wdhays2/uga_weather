class ResultsController < ApplicationController
  def show
    @results = GatherResults.process(date: params[:date])
    @chart_display = ChartDisplay.process(date: params[:date])
  end
end
