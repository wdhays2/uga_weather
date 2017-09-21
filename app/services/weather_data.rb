require 'readline'
require 'date'
require 'open-uri'
require 'pry-byebug'
require 'pry'
require 'json'

class WeatherData
  def initialize
    @url = "weather.ggy.uga.edu/data/archive/daily/2008/20080101.txt"
    @data = []
    @raw_data = ""
  end

  def process
    # do something


    # return data
    @data = get_data_from_url
  end

  def get_data_from_url
    data = open(@url).read
    extract_data(data)
  end

  # def parse_raw_data
  #   # do something with raw data
  #   # store it into @data as an array of hashes
  #   results = @raw_data
  #   content_type :json
  #   erb results.to_json
  # end



  def extract_data(data)
    data.map do |line|
      line_items = line.chomp.split(' ')
      find_index(line_items)
    end
  end

  def find_index(line_items)
    if 'Humidity'.include?(line_items[0])
      line_items[1].to_f
    elsif !'Ix'.include?(line_items[2])
      line_items[2].to_f
    else
      line_items[3].to_f
    end
  end

  ### Data Calculations ###

  def mean(array)
    total = array.inject(0) { |sum, x| sum + x }
    total.to_f / array.length
  end

  def median(array)
    array.sort!
    length = array.length
    if length.odd?
      array[length / 2]
    else
      item1 = array[length / 2 - 1]
      item2 = array[length / 2]
      mean([item1, item2])
    end
  end

  def sort_results(data)
    wind = []
    humidity = []
    temp = []
    days = data.length / 3
    days.times do
      wind << data.shift
      humidity << data.shift
      temp << data.shift
    end

    [wind, humidity, temp]
  end

  def calculate_results(sorted_data)
    results = {}
    READING_TYPES.each_with_index do |type, indx|
      results[type] = {
        mean: mean(sorted_data[indx]),
        median: median(sorted_data[indx])
      }
    end
    results
  end
end