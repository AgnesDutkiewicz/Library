class DeletePublisherColumnFromBooks < ActiveRecord::Migration[6.1]
  def change
    remove_column :books, :publisher, :string
  end
end
