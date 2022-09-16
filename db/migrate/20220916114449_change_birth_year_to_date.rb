class ChangeBirthYearToDate < ActiveRecord::Migration[6.1]
  def up
    change_column :authors, :birth_year, :datetime
  end

  def down
    change_column :authors, :birth_year, :integer
  end
end
