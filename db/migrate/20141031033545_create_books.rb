class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :asin, null: false, default: ""
      t.string :title
      t.string :author
      t.string :price
      t.string :manufacturer
      t.string :image
      t.date   :publicated_at

      t.timestamps
    end

    add_index :books, :asin, unique: true
  end
end
