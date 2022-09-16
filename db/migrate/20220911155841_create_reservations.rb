class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.datetime :return_date
      t.integer :status, default: 0
      t.references :book, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
