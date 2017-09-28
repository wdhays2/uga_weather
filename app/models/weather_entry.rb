# frozen_string_literal: true

class WeatherEntry < ActiveRecord::Base
  def initialize(params = {})
    super(params)
  end
end
