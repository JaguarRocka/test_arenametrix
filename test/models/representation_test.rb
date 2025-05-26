require "test_helper"

class RepresentationTest < ActiveSupport::TestCase

  test "valid representation" do
    representation = representations(:one)
    assert representation.valid?
  end

  test "should not save representation without start_at" do
    representation = representations(:one)
    representation.start_at = nil
    assert_not representation.valid?
  end

  test "should not save representation without end_at" do
    representation = representations(:one)
    representation.end_at = nil
    assert_not representation.valid?
  end

  test "should not save representation without date" do
    representation = representations(:one)
    representation.date = nil
    assert_not representation.valid?
  end

end
