class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  def index
    @reviews = Review.all
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    authorize! :create, @property
    if @review.save
      flash[:notice] = "New review created"
      respond_to do |format|
        format.html { redirect_to property_path(@review.property) }
        format.js
      end
    else
      render 'new'
    end
  end

  def edit
    authorize! :edit, @property
  end

  def update
    @review = Review.update(review_params)
    authorize! :update, @property
    if @review.save
      flash[:notice] = "Review updated."
      redirect_to property_path
    else
      render 'edit'
    end
  end

    def destroy
      authorize! :update, @property
      @review.destroy
      redirect_to property_path, notice: "Review destroyed!"
    end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:content, :user_id, :property_id)
  end

end
