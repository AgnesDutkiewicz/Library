class CreatePublishers < ActiveRecord::Migration[6.1]
  def change
    create_table :publishers do |t|
      t.string :name, null: false
      t.string :origin

      t.timestamps
    end
  end
end
