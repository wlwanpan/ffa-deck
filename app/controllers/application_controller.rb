class ApplicationController < ActionController::API
  
  def render_status_ok
    render json: { status: :ok }, status: :ok
  end

end