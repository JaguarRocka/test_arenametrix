class CsvImportController < ApplicationController
  def upload
  end

  def import
    if params[:file].nil? || params[:file].content_type != "text/csv"
      flash[:error] = "Veuillez télécharger un fichier CSV valide."
      redirect_to upload_csv_path and return
    else
      begin
        csv_imported = SmarterCSV.process(params[:file])
        csv_imported.each do |row|
          seller = Seller.find_or_create_by(name: row[:filiere_de_vente].to_s.capitalize)
          event = Event.find_or_create_by(name: row[:spectacle].to_s.capitalize)
          customer = Customer.find_or_create_by(email: row[:email].downcase) do |c|
            c.first_name = row[:prenom]
            c.last_name = row[:nom]
            c.address = row[:adresse]
            c.postal_code = row[:code_postal]
            c.country = row[:pays]
            c.age = row[:age].to_i
            c.gender = row[:sexe]
          end

          customer.save! if customer.changed?

          representation = Representation.find_or_create_by(event: event, date: Time.strptime(row[:date_representation], "%d/%m/%y")) do |r|
            r.start_at = "#{r.date} #{row[:heure_representation]}"
            r.end_at = "#{r.date} #{row[:heure_fin_representation]}"
          end

          reservation = Reservation.find_or_create_by(
            customer: customer,
            representation: representation
            ) do |res|
              res.seller = seller
              res.reserved_at = parse_reservation_datetime(row[:date_reservation], row[:heure_reservation])
            end

            Ticket.find_or_create_by(ticket_number: row[:numero_billet]) do |t|
              t.reservation = reservation
              t.price = row[:prix]
              t.category = row[:type_de_produit]
            end
          end
          flash[:success] = "Fichier CSV importé avec succès !"
          redirect_to root_path
      rescue StandardError => e
          flash[:error] = "Erreur lors de l'importation du fichier CSV : #{e.message}"
          redirect_to upload_csv_path and return
      end
    end
  end

  def parse_reservation_datetime(date_str, time_str)
    date_str = date_str.split(' ').first
    time_str = time_str
    datetime_str = "#{date_str} #{time_str}"
    Time.zone.strptime(datetime_str, "%d/%m/%y %H:%M:%S")
  end
end
