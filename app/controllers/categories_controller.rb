class CategoriesController < ApplicationController
  before_action :require_user, except: [:show]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:notice] = 'You created a category'
      redirect_to posts_path
    else
      render :new
    end
  end

  def show
    @category = Category.find_by(slug: params[:id])
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end