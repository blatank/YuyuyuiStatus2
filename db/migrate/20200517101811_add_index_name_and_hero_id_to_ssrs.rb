class AddIndexNameAndHeroIdToSsrs < ActiveRecord::Migration[6.0]
  def change
    remove_index :ssrs, :name
    add_index :ssrs, [:name, :hero_id], unique: true
  end
end
