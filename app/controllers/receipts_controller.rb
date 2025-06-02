class ReceiptsController < ApplicationController
  before_action :set_receipt, only: [ :show, :edit, :update, :destroy ]

  def index
    @receipts = Current.user.receipts.order(purchased_at: :desc)
  end

  def show
  end

  def new
    @receipt = Current.user.receipts.new
  end

  def create
    @receipt = Current.user.receipts.new(receipt_params)

    if @receipt.save
      redirect_to @receipt, notice: "Receipt was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @receipt.update(receipt_params)
      redirect_to @receipt, notice: "Receipt was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @receipt.destroy!

    redirect_to receipts_path, notice: "Receipt was successfully destroyed."
  end

  private

  def receipt_params
    params.expect(receipt: [ :purchased_at, :amount, :currency, :description, photos: [] ])
  end

  def set_receipt
    @receipt = Current.user.receipts.find(params[:id])
  end
end
