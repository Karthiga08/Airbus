require 'test_helper'

class PlanesControllerTest < ActionDispatch::IntegrationTest
  test "should get the all planes details" do
    get '/planes'
    assert_response :success
  end

  test "should get all planes details based on origin, destination and date" do
    get "/planes", params: { origin: 'form_location', destination: 'to_location', date: Date.today, search: true }
    assert_response :success
  end

  test "should get the plane details against the PNR detail" do
    get "/planes", params: { pnr: "EC234561"}
    assert_equal 200, status
    assert_response :success
  end
end
