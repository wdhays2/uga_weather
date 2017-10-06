require 'rails_helper'

RSpec.describe Reading, type: :model do
  before :each do
    @reading = Reading.new
  end

  describe 'reading' do
    it 'is a Reading object' do
      expect(@reading).to be_an_instance_of(Reading)
    end
  end
end
