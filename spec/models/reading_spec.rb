require File.dirname(__FILE__) + '/../spec_helper'

RSpec.describe Reading do
  before :each do
    @reading = Reading.new
  end

  describe 'reading' do
    expect(@reading).to_be_an_instance_of Reading
  end
end
