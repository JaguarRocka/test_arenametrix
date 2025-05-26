require "test_helper"

class EventTest < ActiveSupport::TestCase
  test "should not save event without name" do
    event = Event.new(
      name: nil,
    )
    assert_not event.valid?
  end

  test "should save event with valid name" do
    event = Event.new(
      name: "Concert",
    )
    assert event.valid?
  end

end
