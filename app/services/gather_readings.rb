class GatherReadings
  def self.process(options)
    obj = new(options)
    obj.run
  end

  def initialize(options)
    @readings = []
    weather_date = Date.parse(options[:date] || '2017-01-01')
    @start_date = weather_date - 2.days
    @end_date = weather_date + 2.days
  end

  def run
    retrieve_from_website_and_store_in_database unless has_5_days_of_data?
    retrieve_from_database
    @readings
  end

  def has_5_days_of_data?
    WeatherEntry.select(:entered_on)
                .where('entered_on between ? AND ?', @start_date, @end_date)
                .group(:entered_on)
                .pluck(:entered_on)
                .size == 5
  end

  def retrieve_from_database
    data = {}
    WeatherEntry.where('entered_on between ? AND ?', @start_date, @end_date)
                .order(entered_on: :asc, name: :asc).each do |row|
      data[row.entered_on.to_s] = [] if data[row.entered_on.to_s].nil?
      data[row.entered_on.to_s] << {
        name: row.name,
        max_reading: row.max_reading,
        max_time: row.max_time,
        min_reading: row.min_reading,
        min_time: row.min_time,
        avg_reading: row.avg_reading
      }
    end
    @readings = data.map { |entered_on, wdata| { date: entered_on, data: wdata } }
  end

  def retrieve_from_website_and_store_in_database
    (@start_date..@end_date).each do |date|
      next if WeatherEntry.where(entered_on: date.to_s).exist?
      wd = WeatherData.new(date.strftime('%Y%m%d'))
      readings = wd.process
      readings.values.each { |data| WeatherEntry.create!(data) }
    end
  end
end
