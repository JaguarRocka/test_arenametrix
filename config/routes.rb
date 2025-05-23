Rails.application.routes.draw do
  root "csv_import#upload"
  post "csv_import/import", to: "csv_import#import", as: :import_csv

  get 'event_value', to: 'dashboard#event_value', as: :event_value
  get 'dashboard', to: 'dashboard#home'

  get "up" => "rails/health#show", as: :rails_health_check

end
