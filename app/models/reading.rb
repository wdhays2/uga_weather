# frozen_string_literal: true

class Reading
  include Virtus.model

  attribute :name, String
  attribute :max_reading, Float
  attribute :max_time, Time
  attribute :min_reading, Float
  attribute :min_time, Time
  attribute :avg_reading, Float
  attribute :entered_on, Date
end
