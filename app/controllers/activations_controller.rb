class ActivationsController < ApplicationController
  def index
    @inactive_players = Player.where(activated: false).order(updated_at: :desc)
  end

  def activate
    @player = Player.find(params[:player_id])

    unless @player.activated
      @player.activated = true
      @player.skip_password = true
      email_id = @player.email_id

      if @player.save
        flash[:success] = "Player(#{email_id}) activated successfully."
      else
        flash[:danger] = 'Something went wrong. ' \
                         "Player(#{email_id}) activation failed."
      end
    end

    redirect_to(activations_index_path)
  end
end
