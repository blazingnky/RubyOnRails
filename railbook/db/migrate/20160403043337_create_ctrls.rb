class CreateCtrls < ActiveRecord::Migration
  def change
    create_table :ctrls do |t|

      t.timestamps null: false
    end
  end
end
