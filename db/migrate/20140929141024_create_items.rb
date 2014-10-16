class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :asin
      t.integer :bookshelf_id
      t.integer :category_id, default: 0, null: false
      t.string :image
      t.integer :rank, default: 0, null: false
      t.integer :status, default: 0, null: false  # 0:未設定, 1:読みたい, 2:今読んでる, 3:読み終わった, 4:積読

      t.timestamps
    end

    add_index :items, :bookshelf_id
  end
end
