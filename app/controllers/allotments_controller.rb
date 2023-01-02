class  AllotmentsController < ApplicationController
  
  def index
    @allotments = Allotment.all
  end

  def new
    @allotment = Allotment.new
    @non_admins = User.where(admin: false)
  end

  def create
    @allotment = Allotment.new(allotment_params)
    if Allotment.exists?(user_id: @allotment.user_id, item_id: @allotment.item_id, dealloted_at: nil)
      render 'new', flash: { danger: "The specific user was recently alloted this product and has not been deallocated." }
    else
      @item = Item.find(@allotment.item_id)
      if @item.in_stock < @allotment.allotment_quantity.to_i
        @non_admins = User.where(admin: false)
        redirect_to new_allotment_path, flash: { warning: "Total stock of this item is NOT sufficient for this allotment." }
      elsif @allotment.save
        successful_stock_update
      else
        render 'new'
      end
    end
  end

  def edit
    @allotment = Allotment.find(params[:id])
  end

  def update
    @allotment = Allotment.find(params[:id])
    @item = Item.find(@allotment.item_id)
    if @item.in_stock < update_quantity_params[:allotment_quantity].to_i
      redirect_to edit_allotment_path(@item), flash: { warning: "Total stock of this item is NOT sufficient for this allotment." }
    elsif @allotment.update(update_quantity_params)
      successful_stock_update
    else
      render 'edit' 
    end
  end

  def deallot
    @allotment = Allotment.find(params[:id])
    @item = Item.find(@allotment.item_id)
    if @allotment.update_attribute(:dealloted_at,DateTime.now)
      @item.update_attribute(:in_stock, (@item.in_stock + @allotment.allotment_quantity))
      redirect_to allotments_url, flash:{success: "Item dealloted successfully."}
    end
  end

  private

  def allotment_params
    params.require(:allotment).permit(:user_id, :item_id, :allotment_quantity)
  end

  def update_quantity_params
    params.require(:allotment).permit(:allotment_quantity)
  end

  def successful_stock_update
    @item.in_stock = @item.total_stock - @allotment.allotment_quantity.to_i
    @item.update_attribute(:in_stock, @item.in_stock)
    redirect_to allotments_url, flash: { success: "Allotment quantity updated successfully." }
    #notify_admins_about_shortage(@item)
  end

  
end