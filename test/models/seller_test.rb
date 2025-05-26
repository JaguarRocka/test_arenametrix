require "test_helper"

class SellerTest < ActiveSupport::TestCase

  test "should not save seller without name" do
    seller = Seller.new(name: nil)
    assert_not seller.valid?
  end

  test "should save seller with valid name" do
    seller = Seller.new(name: "Ticket Seller")
    assert seller.valid?
  end

  test "should not save seller with duplicate name" do
    Seller.create!(name: "Unique Seller")
    duplicate_seller = Seller.new(name: "Unique Seller")
    assert_not duplicate_seller.valid?
  end
end
