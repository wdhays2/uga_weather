# frozen_string_literal: true

module ReadingsHelper
  def readings_date(options)
    begin
      @w_date = Date.parse(options[:date])
    rescue ArgumentError
      reset_date
    end
    if @w_date >= Date.yesterday || @w_date < Date.parse('2002-09-09')
      reset_date
    end
    @start_date = @w_date - 2.days
    @end_date = @w_date + 2.days
  end

  def reset_date
    @w_date = Date.today - 3.days
  end

  def db_has_5_days_of_data?
    WeatherEntry.select(:entered_on)
                .where('entered_on between ? AND ?', @start_date, @end_date)
                .group(:entered_on)
                .pluck(:entered_on)
                .size == 5
  end

  def retrieve_from_website_and_store_in_database
    (@start_date..@end_date).each do |date|
      next if WeatherEntry.where(entered_on: date.to_s).exists?
      wd = WeatherData.new(date.strftime('%Y%m%d'))
      readings = wd.process
      readings.each_value { |data| WeatherEntry.create!(data) }
    end
  end
end
