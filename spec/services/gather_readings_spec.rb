# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GatherReadings do
  context 'instance methods' do
    it 'loads default weather data if given an invalid date' do
      expect { GatherReadings.new(date: 'sheep') }.to_not raise_error
    end

    it 'loads default weather data if given a date out of the range' do
      expect { GatherReadings.new(date: '20010101') }.to_not raise_error
    end

    it 'loads default weather data if given a future date' do
      expect { GatherReadings.new(date: '21010101') }.to_not raise_error
    end
  end
end
