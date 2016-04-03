class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.date :birth
      t.text :address
      t.string :ctype
      t.binary :photo

      t.timestamps null: false
    end
  end
end
