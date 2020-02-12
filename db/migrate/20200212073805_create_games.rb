class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.date :played_on
      t.integer :time_slot, default: 2000
      t.integer :duration, default: 1

      t.timestamps
    end
  end
end
