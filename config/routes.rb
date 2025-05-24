Rails.application.routes.draw do
  root "dashboard#home"
  get 'event_value', to: 'dashboard#event_value', as: :event_value

  get 'import_csv', to: 'csv_import#upload', as: :upload_csv
  post "/import", to: "csv_import#import", as: :import_csv


  get "up" => "rails/health#show", as: :rails_health_check

end
