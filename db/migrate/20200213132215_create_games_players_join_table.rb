class CreateGamesPlayersJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_table :games_players, id: false do |t|
      t.bigint :game_id
      t.bigint :player_id
    end

    add_index :games_players, :game_id
    add_index :games_players, :player_id
  end
end
