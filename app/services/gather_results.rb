# frozen_string_literal: true

class GatherResults
  include ReadingsHelper

  def self.process(options)
    obj = new(options)
    obj.run
  end

  def initialize(options)
    @readings = []
    result_date(options)
  end

  def run
    retrieve_from_website_and_store_in_database unless db_has_data?
    retrieve_from_database
    @readings
  end

  def retrieve_from_database
    data = {}
    WeatherEntry.where('entered_on between ? AND ?', @start_date, @end_date)
                .order(entered_on: :asc, name: :asc).each do |row|
      data[row.entered_on.to_s] = [] if data[row.entered_on.to_s].nil?
      build_arrays_by_date(data, row)
    end
    @readings = data.map { |entered, wdata| { date: entered, data: wdata } }
  end

  def build_arrays_by_date(data, row)
    data[row.entered_on.to_s] << {
      name: row.name,
      max_reading: row.max_reading,
      max_time: row.max_time,
      min_reading: row.min_reading,
      min_time: row.min_time,
      avg_reading: row.avg_reading
    }
  end
end
