# app/controllers/families_controller.rb
class FamiliesController < ApplicationController

  require "csv"
  def new
    @family = Family.new
  end

  def create
    @family = Family.new(family_params)

    if @family.save
      # Ouvrir ton Google Sheet
      spreadsheet = GOOGLE_DRIVE_SESSION.spreadsheet_by_key("1080S6pimRKyMwcIwuWU3GmZYll0wdvAq12MRzNsdju8")
      worksheet   = spreadsheet.worksheets.first

      # Trouver la prochaine ligne libre
      next_row = worksheet.num_rows + 1

      # Écrire les valeurs
      worksheet[next_row, 1] = @family.prénom
      worksheet[next_row, 2] = @family.nom
      worksheet[next_row, 3] = @family.age

      # Sauvegarder
      worksheet.save

      redirect_to families_path, notice: "Famille créée avec succès."
    else
      render :new
    end
  end



  def export
    @families = Family.all

    respond_to do |format|
      format.csv do
        # On génère une chaîne CSV
        csv_data = generate_csv(@families)

        # On envoie ce CSV en pièce jointe téléchargeable
        send_data csv_data, filename: "families-#{Date.today}.csv"
      end
    end
  end



  def index
    @families = Family.all
  end

  private

  def family_params
    params.require(:family).permit(:prénom, :nom, :age)
  end

  def generate_csv(families)
    # Si tes colonnes s'appellent 'prénom', 'nom', 'age'
    CSV.generate(headers: true) do |csv|
      # Écrire l'en-tête
      csv << ["prénom", "nom", "age"]

      # Écrire chaque famille
      families.each do |family|
        csv << [family.prénom, family.nom, family.age]
      end
    end
  end
end
