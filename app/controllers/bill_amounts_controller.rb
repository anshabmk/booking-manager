# frozen_string_literal: true

# BillAmounts Controller
class BillAmountsController < ApplicationController
  skip_before_action :require_login
  before_action :set_bill_amount, only: %i[show]

  def show; end

  private

  def set_bill_amount
    @bill_amount = BillAmount.find_by(token: params[:token])
  end
end
