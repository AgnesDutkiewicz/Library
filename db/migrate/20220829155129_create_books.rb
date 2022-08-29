class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.datetime :publication_date
      t.string :author, null: false
      t.string :publisher

      t.timestamps
    end
  end
end
