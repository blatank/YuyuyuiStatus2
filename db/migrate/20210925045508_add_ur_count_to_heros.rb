class AddUrCountToHeros < ActiveRecord::Migration[6.0]
  def change
    add_column :heros, :ur_count, :integer
  end
end
