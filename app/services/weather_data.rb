# frozen_string_literal: true

require 'readline'
require 'date'
require 'open-uri'
require 'json'

class WeatherData
  def initialize(date)
    @date = date
    @date ||= (Date.today - 1.day).strftime('%Y%m%d')
    @url = url_formatter(date)
  end

  def process
    @raw_data = retreive_data_from_url
    @raw_data.shift
    sort_results
  end

  def url_formatter(date)
    year = date.first(4)
    recent = year.to_i >= 2009
    case recent
    when true
      "http://weather.ggy.uga.edu/data/archive/daily/#{@date}.txt"
    else
      "http://weather.ggy.uga.edu/data/archive/daily/#{year}/#{@date}.txt"
    end
  end

  def retreive_data_from_url
    # add error handler for when date is out of range
    data = open(@url).readlines
    extract_data(data)
  end

  def extract_data(data)
    data.map do |line|
      line.split(/\s{2,}/)
    end
  end

  def sort_results
    results = {}
    @raw_data.each do |row|
      item = row[0].downcase.tr(' ', '_')
      store_data(results, row, item)
    end
    results
  end

  def store_data(results, row, item)
    results[item.to_s] = {
      name: row[0],
      max_reading: row[1],
      max_time: row[2],
      min_reading: row[3],
      min_time: row[4],
      avg_reading: row[5],
      entered_on: @date
    }
  end
end
