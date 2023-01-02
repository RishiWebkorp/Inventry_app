class BrandsController < ApplicationController

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
    @brand = Brand.find(params[:id])
  end

  def update
    @brand = Brand.find(params[:id])
    if @brand.update(brand_params)
      redirect_to @brand, flash: {success: "Brand updated successfully"}
    else
      render 'edit'
    end
  end

  def show
    @brand = Brand.find(params[:id])
  end

  def destroy
    @brand = Brand.find(params[:id])
    @brand.destroy
    redirect_to root_path, flash: { success: "Brand deleted." }, status: 303
  end
  
  private

  def brand_params
    params.require(:brand).permit(:name, :manufacturer, :manufacturer_email, :manufacturer_office)
  end


end