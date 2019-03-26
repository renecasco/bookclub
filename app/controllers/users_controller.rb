class UsersController < ApplicationController
  def show
    binding.pry
    @reviews = Review.where(user: params[:id])
  end
end
