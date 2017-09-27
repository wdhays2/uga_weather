# frozen_string_literal: true

class Reading
  include Virtus.model

  attribute :measurement, String
  attribute :max_reading, Float
  attribute :max_time, Time
  attribute :min_reading, Float
  attribute :min_time, Time
  attribute :average, Float
  attribute :created_on, Date
end
