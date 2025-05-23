class DashboardController < ApplicationController

  def home
    
    @total_reservations = get_total_resevations
    @total_users = get_total_customers
    @average_age = average_customers_age
    @average_price = average_tickets_price
  end

  def event_value
    @event = Event.find(params[:event_id])
    @data_event = {
      total_reservations: get_total_reservations_for_event(@event),
      total_customers: get_total_customers_for_event(@event),
      average_age: average_customers_age_for_event(@event),
      average_price: average_tickets_price_for_event(@event)
    }

    respond_to do |format|
      format.html { render partial: "dashboard/event_result", locals: { event: @event, data: @data_event } }
    end
  end

  private

  def get_total_resevations
    Reservation.count # optimiser ceci
  end

  def get_total_reservations_for_event(event)
    event.reservations.count
  end

  def get_total_customers
    Customer.count # optimiser ceci
  end

  def get_total_customers_for_event(event)
    event.customers.count
  end

  def average_customers_age
    all_ages = Customer.pluck(:age)

    customers_with_age = all_ages.reject{ |a| a  == 0 }
    customers_with_age.sum / customers_with_age.size
  end

  def average_customers_age_for_event(event)
    all_ages = event.customers.pluck(:age)

    customers_with_age = all_ages.reject { |age| age  == 0 }
    if customers_with_age.empty?
      0
    else
      customers_with_age.sum / customers_with_age.size
    end
  end

  def average_tickets_price
    all_prices = Ticket.pluck(:price)
    (all_prices.sum / all_prices.size).round(2)
    #  ici problème car on veut le prix moyen par représentation
  end

  def average_tickets_price_for_event(event)
    prices = event.tickets.pluck(:price)
    (prices.sum / prices.size).round(2)
  end
end
