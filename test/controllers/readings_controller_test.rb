# frozen_string_literal: true

require 'test_helper'

class ReadingsControllerTest < ActionDispatch::IntegrationTest
  test 'should get show' do
    get readings_show_url
    assert_response :success
  end
end
