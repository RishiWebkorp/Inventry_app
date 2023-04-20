module Items
  module ItemModule
    extend ActiveSupport::Concern

    def item_create
      item_data = item_params.merge(in_stock: item_params[:total_stock])
      @item = Item.new(item_data)
      if @item.save
        redirect_to @item, flash: {success: "Item created successfully"}
      else
        render 'new'
      end
    end

    def item_update
      previous_quantity = @item&.total_stock
      if((item_params[:total_stock].to_i - previous_quantity + @item.in_stock) < 0)
        redirect_to edit_item_path(@item), flash: { warning: "Currently more items are alloted than entered values." }
      elsif @item.update(item_params)
        redirect_to @item, flash: { success: "Item updated successfully." }
        @item.in_stock += (@item.total_stock - previous_quantity)
      else
        render 'edit'
      end
    end

  end
end
