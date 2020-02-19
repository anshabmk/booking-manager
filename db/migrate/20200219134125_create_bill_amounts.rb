class CreateBillAmounts < ActiveRecord::Migration[6.0]
  def change
    create_table :bill_amounts do |t|
      t.references :users
      t.references :bills
      t.float :amount

      t.timestamps
    end
  end
end
