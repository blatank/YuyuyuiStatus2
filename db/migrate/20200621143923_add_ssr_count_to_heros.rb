class AddSsrCountToHeros < ActiveRecord::Migration[6.0]
  def change
    add_column :heros, :ssr_count, :integer, default: 0
  end
end
