class ApplicationController < ActionController::API
  include ActionController::Cookies

  def render_unprocessable_entity(error)
    render json: { errors: error.record.errors.full_messages }, status: :unprocessable_entity

  end 

end
