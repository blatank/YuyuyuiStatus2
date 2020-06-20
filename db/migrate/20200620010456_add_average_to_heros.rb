class AddAverageToHeros < ActiveRecord::Migration[6.0]
  def change
    add_column :heros, :hp_ave,       :integer, default: 0
    add_column :heros, :atk_ave,      :integer, default: 0
    add_column :heros, :stamina_ave,  :integer, default: 0
    add_column :heros, :speed_ave,    :integer, default: 0
    add_column :heros, :crt_ave,      :integer, default: 0
    add_column :heros, :cost_ave,     :integer, default: 0
    add_column :heros, :sp_ave,       :integer, default: 0
    add_column :heros, :sp_ratio_ave, :integer, default: 0
    add_column :heros, :sp_atk_ave,   :integer, default: 0
  end
end
