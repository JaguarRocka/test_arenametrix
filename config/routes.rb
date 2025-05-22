Rails.application.routes.draw do
  root "csv_import#upload"

  get "up" => "rails/health#show", as: :rails_health_check

end
