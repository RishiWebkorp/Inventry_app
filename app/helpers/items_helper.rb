module ItemsHelper
  include BrandsHelper
  
  def item_display_name(item)
    if !current_user.admin?
      return "<Item deleted>" if item.nil?
      "#{get_brand_name_by_id item.brand_id} #{item.name} (Qty- #{item.in_stock}) -- #{item.category.name}"
    else
      return "<Item deleted>" if item.nil?
      "#{get_brand_name_by_id item.brand_id} #{item.name}"
    end
  end

  def get_item_by_id(id)
    return nil if id.nil?
    Item.find(id)
  end
end
