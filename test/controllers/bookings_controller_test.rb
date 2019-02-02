require 'test_helper'

class BookingsControllerTest < ActionDispatch::IntegrationTest
  test "should create a booking for users" do
    post "/bookings", params: {user: { name: 'xyz user', date_of_birth: '08-07-1995', gener: 'Female', adult_count: '2', email: 'test@gmail.com', phone_number: "145789663", user_seats_attributes: [ 1, 2,3 ]}}
    assert_response :found
    assert_not_nil User.find_by(name: "xyz user")
  end

  test "should not create a booking for user if user not enter required details them" do
    post "/bookings", params: { user: { name: 'xyz user'}}
    assert_response 200
    assert_nil User.find_by(name: 'xyz user')
  end

  test "user should upgrade their seats" do
    user = User.create(name: 'test_user', date_of_birth: '08-07-1995', gener: 'Female', email: 'test@gmail.com', phone_number: '11111223123')
    plane = Plane.create(name: 'XYZ', plane_type: 'Boing 221', origin: 'Chennai', destination: 'Bangalore')
    first_class_category = SeatCategory.create(plane_id: plane.id, name: 'First Class', number_of_seat_in_row: 2, number_of_rows: 3, price: 450 )
    business_class_category = SeatCategory.create(plane_id: plane.id, name: 'Business Class', number_of_seat_in_row: 3, number_of_rows: 4, price: 350 )
    first_seat = Seat.create(plane_id: plane.id, seat_category_id: first_class_category.id, seat_number: 'FE11111', pnr: 'ew1ds231')
    seat = Seat.create(plane_id: plane.id, seat_category_id: business_class_category.id, seat_number: 'DE11111', pnr: 'ew121231', is_booked: true)
    UserSeat.create(seat_id: seat.id, user_id: user.id)
    post "/bookings/#{user.id}/upgrade_seats", params: { user_seat_ids: [first_seat.id], seat_id: seat.id}
  end

  test "user should cancel seats" do
    user = User.create(name: 'test_user', date_of_birth: '08-07-1995', gener: 'Female', email: 'test@gmail.com', phone_number: '11111223123')
    plane = Plane.create(name: 'XYZ', plane_type: 'Boing 221', origin: 'Chennai', destination: 'Bangalore')
    business_class_category = SeatCategory.create(plane_id: plane.id, name: 'Business Class', number_of_seat_in_row: 3, number_of_rows: 4, price: 350 )
    seat = Seat.create(plane_id: plane.id, seat_category_id: business_class_category.id, seat_number: 'DE11111', pnr: 'ew121231', is_booked: true)
    UserSeat.create(seat_id: seat.id, user_id: user.id)
    post "/bookings/#{user.id}/cancel_seats", params: { seat_id: seat.id}
  end

  test "user should see their booking tickets" do
    user = User.create(name: 'test_user', date_of_birth: '08-07-1995', gener: 'Female', email: 'test@gmail.com', phone_number: '11111223123')
    get "/bookings/#{user.id}/booking_successfull"
    assert_response 200
  end
end
