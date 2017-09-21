require 'test_helper'

class ReadingsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get readings_index_url
    assert_response :success
  end
end
