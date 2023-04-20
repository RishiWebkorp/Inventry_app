class  AllotmentsController < ApplicationController
  before_action :set_allotments_id, only: %i[edit deallot update]

  include Allotments::AllotmentModule

  def index
    @allotments = Allotment.all
  end

  def new
    @allotment = Allotment.new
    @non_admins = User.where(admin: false)
  end

  def create
    @allotment = Allotment.new(allotment_params)
    create_allotment
  end

  def edit
  end

  def update
    update_in_stock
    if @allotment.item.save && @allotment.update(update_quantity_params)
      redirect_to edit_allotment_path, flash: { warning: "Updated" }
    else
      render 'edit'
    end
  end

  def deallot
    deallot_allotment
  end

  private

  def allotment_params
    params.require(:allotment).permit(:user_id, :item_id, :category_id, :allotment_quantity)
  end

  def set_allotments_id
    @allotment = Allotment.find(params[:id])
  end

  def update_quantity_params
    params.require(:allotment).permit(:allotment_quantity)
  end
  
end
