require "test_helper"

class CustomerTest < ActiveSupport::TestCase

  test "should not save customer without email" do
    customer = Customer.new(
      first_name: "John",
      last_name: "Doe",
      email: nil,
      postal_code: "12345",
      country: "France",
      age: 30
    )
    assert_not customer.valid? # ✅ Le client ne doit pas être valide sans email
  end

  test "should save customer with valid email" do
    customer = Customer.new(
      first_name: "John",
      last_name: "Doe",
      email: "john@example.com",
      postal_code: "12345",
      country: "France",
      age: 30
    )
    assert customer.valid? # ✅ Le client doit être valide avec un email
  end
end
