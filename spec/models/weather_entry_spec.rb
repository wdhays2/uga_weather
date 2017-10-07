# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WeatherEntry, type: :model do
  before :each do
    @we = WeatherEntry.new
  end

  describe 'Weather entry' do
    it 'is a WeatherEntry object' do
      expect(@we).to be_an_instance_of(WeatherEntry)
    end
  end
end
