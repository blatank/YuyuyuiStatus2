class AddIconUrlToHeros < ActiveRecord::Migration[6.0]
  def change
    add_column :heros, :icon_url, :string, default: ''
  end
end
