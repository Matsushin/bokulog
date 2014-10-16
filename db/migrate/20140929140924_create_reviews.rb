class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :item_id
      t.string  :body

      t.timestamps
    end

    add_index :reviews, :item_id
  end
end
