class BillsController < ApplicationController
  before_action :set_bill, only: %i[show edit update send_notification_message]

  def index
    @bills = Bill.order(created_at: :desc)
  end

  def show; end

  def new
    @bill = Bill.new
  end

  def create
    @bill = Bill.new(bill_params)

    respond_to do |format|
      if @bill.save
        @bill.generate_bill_amounts

        success_notice = 'Bill was successfully generated.'

        format.html { redirect_to @bill, notice: success_notice }
        format.json { render :show, status: :created, location: @bill }
      else
        format.html { render :new }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @bill.update(bill_params)
        @bill.update_bill_amounts

        success_notice = 'Bill was successfully updated.'

        format.html { redirect_to @bill, notice: success_notice }
        format.json { render :show, status: :ok, location: @bill }
      else
        format.html { render :edit }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  def send_notification_message
    @bill.send_notification_message

    success_notice = 'Notification SMS has been sent successfully.'

    respond_to do |format|
      format.html { redirect_to @bill, notice: success_notice }
      format.json { render :show, status: :ok, location: @bill }
    end
  end

  private

  def set_bill
    @bill = Bill.find(params[:id])
  end

  def bill_params
    params.fetch(:bill, {}).permit(:from_date, :to_date, :fee_per_game)
  end
end
