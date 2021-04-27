class DiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = @merchant.discounts
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.new
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    discount = @merchant.discounts.create(discount_params)

    discount.save

    redirect_to merchant_discounts_path(@merchant)
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])

    @discount.update(discount_params)

    redirect_to merchant_discount_path(@merchant, @discount)
  end

  def destroy
    @merchant = Merchant.find(params[:merchant_id])
    Discount.find(params[:discount_id]).destroy

    redirect_to merchant_discounts_path(@merchant)
  end

  private
  def discount_params
    params.fetch(:discount, {}).permit(:percent_off, :min_threshold, :merchant_id)
  end
end
