class AddActivatedToPlayers < ActiveRecord::Migration[6.0]
  def change
    add_column :players, :activated, :boolean, required: true, default: false
  end
end
