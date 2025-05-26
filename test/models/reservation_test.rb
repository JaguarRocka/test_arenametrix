require "test_helper"

class ReservationTest < ActiveSupport::TestCase

  test "should not save reservation without representation" do
    reservation = Reservation.new(
      representation: nil,
      customer: customers(:one),
      seller: sellers(:one)
    )
    assert_not reservation.valid?
  end

  test "should not save reservation without customer" do
    reservation = Reservation.new(
      representation: representations(:one),
      customer: nil,
      seller: sellers(:one)
    )
    assert_not reservation.valid?
  end

  test "should not save reservation without seller" do
    reservation = Reservation.new(
      representation: representations(:one),
      customer: customers(:one),
      seller: nil
    )
    assert_not reservation.valid?
  end

  test "should save reservation with valid attributes" do
    reservation = Reservation.new(
      representation: representations(:one),
      customer: customers(:one),
      seller: sellers(:one),
      reserved_at: Time.now
    )
    assert reservation.valid?
  end
end
