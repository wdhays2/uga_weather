# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReadingsController, type: :controller do
  describe 'GET #show' do
    before :each do
      @data_params = {
        date: '2016-01-01'
      }
    end

    it 'returns readings for 5 days weather' do
      VCR.use_cassette 'controller/readings' do
        get :show, params: @data_params
        expect(response.status).to eq(200)
      end
    end
  end
end
