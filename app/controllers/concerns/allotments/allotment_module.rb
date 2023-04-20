module Allotments
  module AllotmentModule
    extend ActiveSupport::Concern

    def create_allotment
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

    def successful_stock_update
      @item.in_stock = @item.total_stock - @allotment.allotment_quantity.to_i
      @item.update_attribute(:in_stock, @item.in_stock)
      redirect_to allotments_url, flash: { success: "Allotment quantity updated successfully." }
      #notify_admins_about_shortage(@item)
    end


    def update_in_stock
      @allotment.item.in_stock = @allotment.item.in_stock + @allotment.allotment_quantity - params[:allotment][:allotment_quantity].to_i
    end

    def deallot_allotment
      @allotment.item.in_stock =  @allotment.item.in_stock + @allotment.allotment_quantity
      @allotment.item.save
      if @allotment.update_attribute(:dealloted_at, DateTime.now)
        redirect_to root_path, flash:{success: "Item dealloted successfully."}
      end
    end

  end
end
