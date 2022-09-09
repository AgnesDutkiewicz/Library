class RemoveAuthorFromBooks < ActiveRecord::Migration[6.1]
  def up
    remove_column :books, :author
  end

  def down
    add_column :books, :author, :string
  end
end
