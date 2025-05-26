require "test_helper"

class CsvImportTest < ActionDispatch::IntegrationTest
  test "should import CSV file and create records" do

    csv_content = <<~CSV
      email,prenom,nom,adresse,code_postal,pays,age,sexe,spectacle,date_representation,heure_representation,heure_fin_representation,date_reservation,heure_reservation,numero_billet,prix,type_de_produit,filiere_de_vente
      alice@test.fr,Alice,Martin,12 rue du test,75000,France,28,F,Cyrano de Bergerac,01/06/25,20:00:00,22:00:00,01/05/25,10:30:00,ABC123,50,Abonnement,Fnac
    CSV

    file = Tempfile.new(["test", ".csv"])
    file.write(csv_content)
    file.rewind

    uploaded_file = Rack::Test::UploadedFile.new(file.path, "text/csv")

    assert_difference ["Customer.count", "Event.count", "Representation.count", "Reservation.count", "Ticket.count", "Seller.count"], 1 do
      post import_csv_path, params: { file: uploaded_file }
    end

    follow_redirect!
    assert_response :success
    assert_match "Fichier CSV importé avec succès", response.body

    file.close
    file.unlink
  end

  test "should handle invalid file" do
    csv_content = "this is not a csv at all"

    file = Tempfile.new(["test", ".pdf"])
    file.write(csv_content)
    file.rewind

    uploaded_file = Rack::Test::UploadedFile.new(file.path, "application/pdf")

    assert_no_difference ["Customer.count", "Event.count", "Representation.count", "Reservation.count", "Ticket.count", "Seller.count"] do
      post import_csv_path, params: { file: uploaded_file }
    end

    follow_redirect!
    assert_response :success
    assert_match "Veuillez télécharger un fichier CSV valide", response.body

    file.close
    file.unlink
  end
end
