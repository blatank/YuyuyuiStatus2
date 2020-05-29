class AddImageUrlToSsrs < ActiveRecord::Migration[6.0]
  def change
    add_column :ssrs, :image_url, :string, default: ""
  end
end
