# frozen_string_literal: true

class CreateWeatherEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :weather_entries do |t|
      t.string :name
      t.float :max_reading
      t.time :max_time
      t.float :min_reading
      t.time :min_time
      t.float :avg_reading
      t.date :entered_on
    end
  end
end
