class CreateReadings < ActiveRecord::Migration[5.1]
  def change
    create_table :readings do |t|
      t.integer :max_wind_speed
      t.integer :max_humidity
      t.float :max_temp

      t.timestamps
    end
  end
end
