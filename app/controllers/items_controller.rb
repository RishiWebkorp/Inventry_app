class ItemsController < ApplicationController

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    item_data = item_params.merge(in_stock: item_params[:total_stock])
    @item = Item.new(item_data)
    if @item.save
      redirect_to @item, flash: {success: "Item created successfully"}
    else
      render 'new'
    end
  end 

  def edit
    @item = Item.find(params[:id])
  end

  def update
    previous_quantity = @item.total_stock
    if((item_params[:total_stock].to_i - previous_quantity + @item.in_stock) < 0)
      redirect_to edit_item_path(@item), flash: { warning: "Currently more items are alloted than entered values." }
    elsif @item.update(item_params)
      redirect_to @item, flash: { success: "Item updated successfully." }
      @item.in_stock += (@item.total_stock - previous_quantity)
    else
      render 'edit'
    end
  end

  def show
    @brand = Brand.find_by_id(@item&.brand)
    @category = Category.find_by_id(@item&.category)
  end

  def destroy
    Item.find(params[:id]).destroy
    redirect_to items_url, flash: { success: "Item deleted." }
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :minimum_required_stock, :quantity, :total_stock, :procurement_time_in_weeks, :brand_id, :category_id)
  end
end