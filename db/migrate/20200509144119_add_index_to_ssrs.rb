class AddIndexToSsrs < ActiveRecord::Migration[6.0]
  def change
    add_index :ssrs,        :name, unique: true
    add_index :heros,       :name, unique: true
    add_index :hero_types,  :name, unique: true
    add_index :colors,      :name, unique: true
  end
end
