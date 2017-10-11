# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImportWeather do
  before do
    @date = Date.parse('2017-01-14')
  end

  context 'instance methods' do
    it 'loads weather data if given a valid date' do
      VCR.use_cassette 'services/import_weather' do
        iw = ImportWeather.new(@date)
        expect { iw.weather_import }.to_not raise_error
      end
    end
  end
end
