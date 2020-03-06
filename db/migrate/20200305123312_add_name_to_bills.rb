class AddNameToBills < ActiveRecord::Migration[6.0]
  def change
    add_column :bills, :name, :string, unique: true, limit: 16
  end
end
