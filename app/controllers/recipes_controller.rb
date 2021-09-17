class RecipesController < ApplicationController
  before_action :authorize
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

  

  def index
    recipes = Recipe.where(user_id: session[:user_id])
    render json: recipes, include: :user
  end

  def create
    user = User.find(session[:user_id])
    recipe = user.recipes.create!(recipe_params)
    render json: recipe, include: :user, status: :created
  end

private

  def recipe_params
    params.permit(:title, :instructions, :minutes_to_complete)
  end

  def authorize
    return render json: { errors: ["Not authorized"] }, status: :unauthorized unless session.include? :user_id
  end


end
