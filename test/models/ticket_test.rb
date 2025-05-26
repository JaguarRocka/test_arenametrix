require "test_helper"

class TicketTest < ActiveSupport::TestCase

  test "should not save ticket without ticket_number" do
    ticket = Ticket.new(ticket_number: "",
    price: 50,
    category: "Abonnement")
    assert_not ticket.valid?
  end

  test "should not save ticket without price" do
    ticket = Ticket.new(ticket_number: "12345",
    price: nil,
    category: "Abonnement")
    assert_not ticket.valid?
  end

  test "should not save ticket without category" do
    ticket = Ticket.new(ticket_number: "12345",
    price: 50,
    category: nil)
    assert_not ticket.valid?
  end

  test "should save ticket with valid attributes" do
    reservation = Reservation.create!(
      customer: customers(:one),
      representation: Representation.new(event: Event.new(name: "Concert"), start_at: Time.now, end_at: Time.now + 2.hours, date: Date.today),
      seller: sellers(:one),
      reserved_at: Time.now
    )

    ticket = Ticket.new(ticket_number: "12345",
    price: 50,
    category: "Abonnement",
    reservation: reservation)
    assert ticket.valid?
  end
end
