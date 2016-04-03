class CreateMagazines < ActiveRecord::Migration
  def change
    create_table :magazines do |t|
      t.string :isbn
      t.string :title
      t.integer :price
      t.string :publish
      t.date :published
      t.boolean :cd

      t.timestamps null: false
    end
  end
end
