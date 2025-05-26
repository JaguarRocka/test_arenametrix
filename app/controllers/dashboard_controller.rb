class DashboardController < ApplicationController
  def dashboard
    @total_reservations = get_total(Reservation)
    @total_customers = get_total(Customer)
    @average_age = average_customers_age
    @average_price = average_tickets_price_per_representation
  end

  def event_value
    if params[:event_id].blank?
      render turbo_stream: turbo_stream.update("event_results",
        "<div class='flash text-red-700 bg-red-100 p-4 rounded'>Veuillez sélectionner un événement.</div>".html_safe)
      return
    end

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

  def get_total(model)
    model.count
  end

  def get_total_reservations_for_event(event)
    event.reservations.size
  end

  def get_total_customers_for_event(event)
    event.customers.size
  end

  def average_customers_age
    all_ages = Customer.pluck(:age)
    return 0 if all_ages.empty?

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

  def average_tickets_price_per_representation
    all_prices = []
    representations = Representation.all
    representations.each do |representation|
      prices = representation.tickets.pluck(:price)
      next if prices.empty?
      all_prices << (prices.sum / prices.size).round(2)
    end

    return 0 if all_prices.empty?

    (all_prices.sum / all_prices.size).round(2)
  end

  def average_tickets_price_for_event(event)
    prices = event.tickets.pluck(:price)
    (prices.sum / prices.size).round(2)
  end
end
