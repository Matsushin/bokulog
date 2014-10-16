class CreateBookshelves < ActiveRecord::Migration
  def change
    create_table :bookshelves do |t|
      t.integer :user_id
      t.string :name
      t.string :introduction

      t.timestamps
    end

    add_index :bookshelves, :user_id
  end
end
