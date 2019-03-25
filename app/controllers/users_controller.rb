class UsersController < ApplicationController
  def show
    @reviews = Review.where(user: params[:id])
  end
end
