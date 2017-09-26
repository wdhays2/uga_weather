# frozen_string_literal: true

require 'readline'
require 'date'
require 'open-uri'
require 'pry-byebug'
require 'pry'
require 'json'

class WeatherData
  def initialize
    @url = 'http://weather.ggy.uga.edu/data/archive/daily/2008/20080101.txt'
  end

  def process
    # return data
    @raw_data = retreive_data_from_url
    @raw_data.shift
    sort_results
  end

  def retreive_data_from_url
    data = open(@url).readlines
    extract_data(data)
  end

  # def parse_raw_data
  #   # do something with raw data
  #   # store it into @data as a hash of arrays

  #   # @data = calculate_results(results)
  # end

  def extract_data(data)
    data.map do |line|
      line.split(/\s{2,}/)
    end
  end

  # def find_index(line_items)
  #   if 'Humidity'.include?(line_items[0])
  #     line_items[1].to_f
  #   elsif !'Ix'.include?(line_items[2])
  #     line_items[2].to_f
  #   else
  #     line_items[3].to_f
  #   end
  # end

  ### Data Calculations ###

  # def mean(array)
  #   total = array.inject(0) { |sum, x| sum + x }
  #   total.to_f / array.length
  # end

  # def median(array)
  #   array.sort!
  #   length = array.length
  #   if length.odd?
  #     array[length / 2]
  #   else
  #     item1 = array[length / 2 - 1]
  #     item2 = array[length / 2]
  #     mean([item1, item2])
  #   end
  # end

  def sort_results
    results = {}
    @raw_data.each do |row|
      item = row[0].downcase.tr(' ', '_')
      results[item.to_s] = {
        parameter: row[0],
        max_reading: row[1],
        max_time: row[2],
        min_reading: row[3],
        min_time: row[4],
        average: row[5]
      }
    end
    results
  end

  # def calculate_results(sorted_data)
  #   results = {}
  #   @reading_types.each_with_index do |type, indx|
  #     results[type] = {
  #       mean: mean(sorted_data[indx]),
  #       median: median(sorted_data[indx])
  #     }
  #   end
  #   results
  # end
end
