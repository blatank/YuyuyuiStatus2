class AddFilenameToHeros < ActiveRecord::Migration[6.0]
  def change
    add_column :heros, :filename, :string, default: "hero"
  end
end
