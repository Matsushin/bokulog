class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.integer :item_id
      t.string :name

      t.timestamps
    end

    add_index :tags, :item_id
  end
end
