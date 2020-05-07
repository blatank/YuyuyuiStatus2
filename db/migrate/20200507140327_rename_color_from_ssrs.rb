class RenameColorFromSsrs < ActiveRecord::Migration[6.0]
  def change
    rename_column :ssrs, :color, :color_id
  end
end
