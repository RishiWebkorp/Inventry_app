class BrandsController < ApplicationController

  before_action :set_brand_id, only: %i[edit update destroy show]

  def index
    @brands = Brand.all
  end

  def create
    @brand = Brand.new(brand_params)
    if @brand.save
      redirect_to @brand, flash: {success: "Brand created successfully"}
    else
      render 'new'
    end
  end

  def new
    @brand = Brand.new
  end

  def edit
  end

  def update
    if @brand.update(brand_params)
      redirect_to @brand, flash: {success: "Brand updated successfully"}
    else
      render 'edit'
    end
  end

  def show
  end

  def destroy
    @brand.destroy
    redirect_to root_path, flash: { success: "Brand deleted." }, status: 303
  end
  
  private

  def brand_params
    params.require(:brand).permit(:name, :manufacturer, :manufacturer_email, :manufacturer_office)
  end 
  
  def set_brand_id
    @brand = Brand.find(params[:id])
  end

end