class CreateHeros < ActiveRecord::Migration[6.0]
  def change
    create_table :heros do |t|
      t.string :name
      t.references :hero_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
