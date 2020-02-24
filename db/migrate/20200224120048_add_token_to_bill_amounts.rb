class AddTokenToBillAmounts < ActiveRecord::Migration[6.0]
  def change
    add_column :bill_amounts, :token, :string
    add_index :bill_amounts, :token, unique: true
  end
end
