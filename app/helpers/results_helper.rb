# frozen_string_literal: true

module ResultsHelper
  def link_to_js_method(category, results)
    date_str = (results[0][:date].to_date - 2.days).to_s.delete('-')
    link_to(
      category[:name],
      '#',
      onclick: "setCategoryAndDateToUse('#{category[:name]}', '#{date_str}')"
    )
  end

  def readings_date(options)
    begin
      @w_date = Date.parse(options[:date])
    rescue StandardError
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

  def result_date(options)
    check_date(options)
    @start_date = @end_date = @w_date + 2.days
  end

  def check_date(options)
    begin
      @w_date = Date.parse(options[:date])
    rescue StandardError
      reset_date
    end
    reset_date if @w_date >= Date.yesterday ||
                  @w_date < Date.parse('2002-09-09')
  end

  def db_has_5_days_of_data?
    WeatherEntry.select(:entered_on)
                .where('entered_on between ? AND ?', @start_date, @end_date)
                .group(:entered_on)
                .pluck(:entered_on)
                .size == 5
  end

  def db_has_data?
    WeatherEntry.select(:entered_on)
                .where('entered_on between ? AND ?', @start_date, @end_date)
                .group(:entered_on)
                .pluck(:entered_on)
                .size == 1
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
