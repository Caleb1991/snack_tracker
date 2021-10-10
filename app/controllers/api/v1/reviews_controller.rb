class Api::V1::ReviewsController < ApplicationController
  def create
    review = Review.create(review_attributes)

    if review.save
      render json: ReviewSerializer.new_review(review)
    else
      render json: ReviewSerializer.creation_error(review), status: 409
    end
  end

  def update
    begin
      review = Review.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      return render json: ReviewSerializer.review_not_found, status: 409
    end

    review.update(review_attributes)
    render json: ReviewSerializer.updated_review(review_attributes, review.id)
  end

  def destroy
    begin
      review = Review.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      return render json: ReviewSerializer.review_not_found, status: 409
    end

    review.delete
    render json: ReviewSerializer.review_deleted
  end

  private
  def review_attributes
    JSON.parse(request.body.read, symbolize_names: true)
  end
end
