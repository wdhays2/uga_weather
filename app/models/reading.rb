# frozen_string_literal: true

class Reading < ApplicationRecord
  include Virtus.model

  attribute :max_wind_direction, Integer
  attribute :max_wind_direction_time, Time
  attribute :min_wind_direction, Integer
  attribute :min_wind_direction_time, Time
  attribute :avg_wind_direction, Integer

  attribute :max_wind_speed, Integer
  attribute :max_wind_speed_time, Time
  attribute :min_wind_speed, Integer
  attribute :min_wind_speed_time, Time
  attribute :avg_wind_speed, Integer

  attribute :max_humidity, Float
  attribute :max_humidity_time, Time
  attribute :min_humidity, Float
  attribute :min_humidity_time, Time
  attribute :avg_humidity, Float

  attribute :max_temp, Float
  attribute :max_temp_time, Time
  attribute :min_temp, Float
  attribute :min_temp_time, Time
  attribute :avg_temp, Float

  attribute :max_barometer, Float
  attribute :max_barometer_time, Time
  attribute :min_barometer, Float
  attribute :min_barometer_time, Time
  attribute :avg_barometer, Float

  attribute :max_uv_index, Float
  attribute :max_uv_index_time, Time
  attribute :min_uv_index, Float
  attribute :min_uv_index_time, Time
  attribute :avg_uv_index, Float

  attribute :max_radiation, Float
  attribute :max_radiation_time, Time
  attribute :min_radiation, Float
  attribute :min_radiation_time, Time
  attribute :avg_radiation, Float

  attribute :max_wind_chill, Float
  attribute :max_wind_chill_time, Time
  attribute :min_wind_chill, Float
  attribute :min_wind_chill_time, Time
  attribute :avg_wind_chill, Float

  attribute :max_heat_index, Float
  attribute :max_heat_index_time, Time
  attribute :min_heat_index, Float
  attribute :min_heat_index_time, Time
  attribute :avg_heat_index, Float

  attribute :max_dew_point, Float
  attribute :max_dew_point_time, Time
  attribute :min_dew_point, Float
  attribute :min_dew_point_time, Time
  attribute :avg_dew_point, Float
end
