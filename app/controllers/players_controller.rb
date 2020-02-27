class PlayersController < ApplicationController
  skip_before_action :require_admin_login, only: %i[new create show edit update]
  before_action :require_login, only: %i[show edit update]
  before_action :set_player, only: %i[show edit update destroy]

  # GET /players
  # GET /players.json
  def index
    @players = Player.all
  end

  # GET /players/1
  # GET /players/1.json
  def show
    # Players are not authorized to view the details of other users.
    redirect_to(current_user) if player_logged_in? && @player.id != current_user.id
  end

  # GET /players/new
  def new
    if player_logged_in?
      # Redirects to the player's profile page.
      redirect_to(current_user)
    else
      @player = Player.new
    end
  end

  # GET /players/1/edit
  def edit
    # Players are not authorized to edit the details of other users.
    redirect_to(current_user) if player_logged_in? && @player.id != current_user.id
  end

  # POST /players
  # POST /players.json
  def create
    @player = Player.new(player_params)

    respond_to do |format|
      if @player.save
        format.html do
          if admin_logged_in?
            flash[:success] = 'Added new player successfully.'

            redirect_to(@player)
          else
            flash[:success] = "Welcome, #{@player.firstname}. Contact administrator for account activation."

            redirect_to(login_url)
          end
        end

        format.json { render :show, status: :created, location: @player }
      else
        format.html { render :new }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /players/1
  # PATCH/PUT /players/1.json
  def update
    # Players are not authorized to edit the details of other users.
    redirect_to(current_user) if player_logged_in? && @player.id != current_user.id

    email_changed = player_params[:email_id] != @player.email_id
    mobile_changed = player_params[:mobile_number] != @player.mobile_number
    email_or_mobile_changed = email_changed || mobile_changed
    activated = !(player_logged_in? && email_or_mobile_changed)

    respond_to do |format|
      if @player.update(player_params.merge(activated: activated))
        format.html do
          if activated
            flash[:success] = 'Player was successfully updated.'

            redirect_to(@player)
          else
            flash[:danger] = 'Your account is temporarily de-activated. Contact administrator for activation.'

            log_out
            redirect_to(login_url)
          end
        end

        format.json { render :show, status: :ok, location: @player }
      else
        format.html { render :edit }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1
  # DELETE /players/1.json
  def destroy
    @player.destroy

    respond_to do |format|
      flash[:success] = 'Player was successfully destroyed.'

      format.html { redirect_to players_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def player_params
      params.fetch(:player, {})
            .permit(:firstname, :lastname, :mobile_number, :email_id, :password, :password_confirmation)
    end
end
