class CsvImportController < ApplicationController
  def upload
  end

  def import
    begin
      csv_imported = SmarterCSV.process(params[:file])
      csv_imported.each do |row|
        seller = Seller.find_or_create_by(name: row[:filiere_de_vente].capitalize)
        event = Event.find_or_create_by(name: row[:spectacle].capitalize)
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

        representation = Representation.find_or_create_by(event: event, date: row[:date_representation]) do |r|
          r.start_at = row[:heure_representation]
          r.end_at = row[:heure_fin_representation]
        end

        reservation = Reservation.find_or_create_by(
          customer: customer,
          representation: representation
        ) do |res|
          res.seller = seller
          res.reserved_at = "#{row[:date_reservation]} #{row[:heure_reservation]}"
        end

        Ticket.find_or_create_by(ticket_number: row[:numero_billet]) do |t|
          t.reservation = reservation
          t.price = row[:prix]
          t.category = row[:type_de_produit]
        end
      end
      flash[:success] = "Fichier CSV importé avec succès !"
      redirect_to dashboard_path
    rescue StandardError => e
      flash[:error] = "Erreur lors de l'importation du fichier CSV : #{e.message}"
      redirect_to root_path and return
    end
  end
end
