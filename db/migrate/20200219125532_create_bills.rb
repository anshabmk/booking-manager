class CreateBills < ActiveRecord::Migration[6.0]
  def change
    create_table :bills do |t|
      t.date :from_date, required: true
      t.date :to_date, required: true
      t.float :fee_per_game

      t.timestamps
    end
  end
end
