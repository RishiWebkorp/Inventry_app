class CategoriesController < ApplicationController

  before_action :set_category_id, only: %i[edit update show destroy]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to @category, flash: {success: "Category was successfully created"}
    else
      render 'new'
    end
  end

  def edit
  end

  def show
  end

  def update
    if @category.update(category_params)
      redirect_to @category, flash: {success: "Category was successfully updated"}
    else
      render 'edit'
    end
  end

  def destroy
    @category.destroy
    redirect_to category_path
  end

  private

  def category_params
    params.require(:category).permit(:name, :description)
  end

  def set_category_id
    @category = Category.find(params[:id])
  end
end