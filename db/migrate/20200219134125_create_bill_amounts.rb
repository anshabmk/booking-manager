class CreateBillAmounts < ActiveRecord::Migration[6.0]
  def change
    create_table :bill_amounts do |t|
      t.belongs_to :player
      t.belongs_to :bill
      t.float :amount

      t.timestamps
    end
  end
end
