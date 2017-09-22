# frozen_string_literal: true

class Reading < ApplicationRecord
  include Virtus.model

  attribute :max_wind_speed, Integer
  attribute :max_humidity, Integer
  attribute :max_temp, Float
end
