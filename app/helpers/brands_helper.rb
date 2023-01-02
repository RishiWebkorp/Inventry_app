module BrandsHelper
  def get_brand_name_by_id(id)
    return "<Brand N/A>" if id.nil?
    Brand.find_by('name')
  end
end
