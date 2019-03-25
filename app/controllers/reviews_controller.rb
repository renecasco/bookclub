class ReviewsController < ApplicationController

  def new
    @book = Book.find(params[:book_id])
    @review = @book.reviews.new
  end

  def create
    @book = Book.find(params[:book_id])
    @review = @book.reviews.new(review_params)
    @review.save
    redirect_to book_path(@book)
  end

  def destroy
    review = Review.find(params[:id]).destroy
    redirect_to user_path(review.user)
  end

  private

  def review_params
    params.require(:review).permit(:user, :rating, :title, :description)
  end
end
