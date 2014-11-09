class DeleteBookshelves < ActiveRecord::Migration
  def change
    drop_table :bookshelves
  end
end
