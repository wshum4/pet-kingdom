class ReviewsController < ApplicationController
  def new
    @review = Review.new
    @request = Request.find(params[:request_id])
    authorize(@review)
  end

  def create
    @review = Review.new(review_params)
    @request = Request.find(params[:request_id])
    @review.request = @request
    authorize(@review)
    if @review.save
      redirect_to request_path(@request)
    else
      render 'new'
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :content)
  end
end
