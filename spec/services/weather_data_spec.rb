# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WeatherData do
  context 'instance methods' do
    it 'loads weather data if given a valid date' do
      wd = WeatherData.new('20170101')
      expect { wd.process }.to_not raise_error
    end

    it 'loads weather data if given an older valid date- modified url' do
      wd2 = WeatherData.new('20070208')
      expect { wd2.process }.to_not raise_error
    end
  end
end
