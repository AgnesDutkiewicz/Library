class ChangeBirthYearToBirthDate < ActiveRecord::Migration[6.1]
  def change
    rename_column :authors, :birth_year, :birth_date
  end
end
