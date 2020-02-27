class ActivationsController < ApplicationController
  def index
    @inactive_players = Player.where(activated: false).order(created_at: :asc)
  end

  def activate
    @player = Player.find(params[:player_id])

    unless @player.activated
      @player.update!(activated: true)

      flash[:success] = "Player account with e-mail #{@player.email_id} activated successfully."
    end

    redirect_to(activations_index_path)
  end
end
