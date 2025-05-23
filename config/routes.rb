Rails.application.routes.draw do
  root "csv_import#upload"
  post "csv_import/import", to: "csv_import#import", as: :import_csv

  get "up" => "rails/health#show", as: :rails_health_check

end
