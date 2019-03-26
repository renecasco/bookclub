class UsersController < ApplicationController
  def show
    @reviews_user = Review.find_by(user: params[:id])

    @reviews = Review.where(user: params[:id])
    .order(:created_at)
    if params[:sort] == 'desc'
      @reviews = Review.where(user: params[:id])
      .order(created_at: :desc)
    end
  end
end
