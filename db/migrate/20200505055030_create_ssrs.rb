class CreateSsrs < ActiveRecord::Migration[6.0]
  def change
    create_table :ssrs do |t|
      t.string :name
      t.integer :color
      t.string :rare
      t.integer :hp
      t.integer :atk
      t.integer :stamina
      t.integer :speed
      t.integer :crt
      t.integer :cost
      t.integer :sp
      t.integer :sp_ratio
      t.integer :sp_atk
      t.references :hero, null: false, foreign_key: true

      t.timestamps
    end
    # ユニーク
    add_index :ssrs, [:name, :hero], unique: true
  end
end
