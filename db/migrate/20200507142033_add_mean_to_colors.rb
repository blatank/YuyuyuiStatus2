class AddMeanToColors < ActiveRecord::Migration[6.0]
  def change
    add_column :colors, :mean, :string
  end
end
