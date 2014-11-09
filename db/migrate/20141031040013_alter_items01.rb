class AlterItems01 < ActiveRecord::Migration
  def change
    remove_column :items, :asin
    remove_column :items, :image
    rename_column :items, :bookshelf_id, :user_id
    add_column :items, :book_id, :integer
    add_column :items, :review, :string

  end
end
