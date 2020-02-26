# frozen_string_literal: true

# BillAmounts Controller
class BillAmountsController < ApplicationController
  skip_before_action :require_admin_login
  before_action :set_bill_amount, only: %i[show]
  before_action :require_player_login, only: %i[index]

  def index
    @bill_amounts = BillAmount.where(player_id: current_user.id)
  end

  def show; end

  private

  def set_bill_amount
    @bill_amount = BillAmount.find_by(token: params[:token])
  end
end
