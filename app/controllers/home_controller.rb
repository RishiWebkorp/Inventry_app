class HomeController < ApplicationController

  def index
  end

  def user_show
    @users = User.all
  end

end